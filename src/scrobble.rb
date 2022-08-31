require_relative 'track'

class Scrobble
  attr_accessor :track

  def initialize(track, uts)
    @track = track
    @uts = uts
  end

  def self.build_from_service(response)
    now_playing = response.fetch("nowplaying", false)
    unless now_playing
      track = Track.new(
        response.fetch("artist", {}).fetch("content", ""),
        response.fetch("artist", {}).fetch("mbid", ""),
        response["mbid"] == {} ? "" : response["mbid"],
        response.fetch("name", "")
      )
      Scrobble.new(
        track,
        response.fetch("date", {}).fetch("uts")
      )
    end
  end
end
