require "google/cloud/secret_manager"
require 'rspotify'

class SpotifyService
  def initialize
    # Authorize spotify client
    @client = Google::Cloud::SecretManager.secret_manager_service
    spotify_app_id = @client.access_secret_version(name: 'projects/74519756062/secrets/spotify-app-id/versions/1').payload.data
    spotify_secret = @client.access_secret_version(name: 'projects/74519756062/secrets/spotify-app-secret/versions/1').payload.data
    RSpotify::authenticate(spotify_app_id, spotify_secret)
  end

  def get_authorized_user(user_hash_secret_name)
    rspotify_user_hash = @client.access_secret_version(name: user_hash_secret_name).payload.data
    RSpotify::User.new(JSON.parse(rspotify_user_hash.gsub("=>", ":").gsub(/\bnil\b/, "null")))
  end

  def update_playlist(rspotify_user, playlist_id, scrobbles)
    tracks = []
    scrobbles.each do |s|
      track = RSpotify::Track.search(s[0].to_spotify_query).first
      tracks << track unless track == nil
    end
    RSpotify::Playlist.find(rspotify_user.id, playlist_id).replace_tracks!(tracks)
  end
end
