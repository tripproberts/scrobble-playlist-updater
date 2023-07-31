require 'lastfm'

require_relative 'scrobble'

class ScrobbleService
  API_KEY = ENV['LAST_FM_API_KEY']
  SECRET = 'not-needed'

  def initialize
    @session = get_session
  end

  def get_scrobbles(user:, limit:, from:, to:)
    tracks = @session.user.get_recent_tracks(user, limit, nil, to, from)
    tracks = [tracks] if tracks.is_a? Hash
    tracks.nil? ? [] : tracks.map { |r|
      Scrobble.build_from_service(r)
    }.compact
  end

  private

  def get_session
    Lastfm.new(ScrobbleService::API_KEY, ScrobbleService::SECRET)
  end

end
