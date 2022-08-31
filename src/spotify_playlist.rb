require 'rspotify'

class SpotifyPlaylist

  def self.update_on_spotify(rspotify_user, playlist_id, scrobbles)
    tracks = []
    scrobbles.each do |s|
      track = RSpotify::Track.search(s[0].to_spotify_query).first
      tracks << track unless track == nil
    end
    RSpotify::Playlist.find(rspotify_user.id, playlist_id).replace_tracks!(tracks)
  end
end
