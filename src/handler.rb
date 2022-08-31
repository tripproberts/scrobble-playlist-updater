require 'functions_framework'
require 'active_support/time'
require 'rspotify'
require "google/cloud/secret_manager"

require_relative 'scrobble_user'
require_relative 'spotify_playlist'

FunctionsFramework.cloud_event "update_scrobble_playlist" do |event|
  run
end

def run
  user = 'tripproberts'
  playlist_id = '6K5607lu5oKcfV5hVRhjtQ'

  # Authorize spotify client
  client = Google::Cloud::SecretManager.secret_manager_service
  spotify_app_id = client.access_secret_version(name: 'projects/74519756062/secrets/spotify-app-id/versions/1').payload.data
  spotify_secret = client.access_secret_version(name: 'projects/74519756062/secrets/spotify-app-secret/versions/1').payload.data
  RSpotify::authenticate(spotify_app_id, spotify_secret)

  # Authorize user
  rspotify_tripproberts_hash = client.access_secret_version(name: 'projects/74519756062/secrets/rspotify-tripproberts-hash/versions/2').payload.data
  rspotify_user = RSpotify::User.new(JSON.parse(rspotify_tripproberts_hash.gsub("=>", ":").gsub(/\bnil\b/, "null")))

  # Get last 7 days scrobbles
  scrobbles = []
  (0..6).each do |dayOffset|
    start_date = Time.now.in_time_zone('EST').beginning_of_day - (dayOffset + 1).days
    end_date = Time.now.in_time_zone('EST').beginning_of_day - dayOffset.days
    scrobbles += ScrobbleUser.fetch_scrobbles(user, from: start_date, to: end_date)
  end

  # Calculate top ten tracks based on scrobbles
  top_ten_tracks = to_top_ten_tracks(scrobbles)

  # Update playlist on spotify
  SpotifyPlaylist.update_on_spotify(rspotify_user, playlist_id, top_ten_tracks)
end

def to_top_ten_tracks(scrobbles)
  track_listen_count = Hash.new(0)
  scrobbles.each { |s| track_listen_count[s.track] += 1 }
  ordered_tracks = track_listen_count.sort_by(&:last).reverse
  ordered_tracks[0, 10]
end
