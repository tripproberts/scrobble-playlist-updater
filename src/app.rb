require 'functions_framework'
require 'active_support/time'

require_relative 'spotify_service'
require_relative 'scrobble_service'

FunctionsFramework.cloud_event "update_scrobble_playlist" do |event|
  run
end

def run
  user = 'tripproberts'
  playlist_id = '6K5607lu5oKcfV5hVRhjtQ'
  user_hash_secret_name = 'projects/74519756062/secrets/rspotify-tripproberts-hash/versions/2'

  # Get last 7 days scrobbles
  scrobbles = []
  scrobble_service = ScrobbleService.new
  (0..6).each do |dayOffset|
    start_date = Time.now.in_time_zone('EST').beginning_of_day - (dayOffset + 1).days
    end_date = Time.now.in_time_zone('EST').beginning_of_day - dayOffset.days
    scrobbles += scrobble_service.get_scrobbles(user: user, limit: 200, from: start_date.to_i, to: end_date.to_i)
  end

  # Calculate top ten tracks based on number of scrobbles
  top_ten_tracks = to_top_ten_tracks(scrobbles)

  # Fetch authorized user and update playlist on spotify
  spotify_service = SpotifyService.new
  authorized_user = spotify_service.get_authorized_user(user_hash_secret_name)
  spotify_service.update_playlist(authorized_user, playlist_id, top_ten_tracks)
end

def to_top_ten_tracks(scrobbles)
  track_listen_count = Hash.new(0)
  scrobbles.each { |s| track_listen_count[s.track] += 1 }
  ordered_tracks = track_listen_count.sort_by(&:last).reverse
  ordered_tracks[0, 10]
end
