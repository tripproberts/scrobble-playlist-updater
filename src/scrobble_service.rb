require 'lastfm'

class ScrobbleService
  API_KEY = '7f60c8b3761c4cb962ad5fbf8dc6ef90'
  SECRET = 'not-needed'

  def initialize
    @session = get_session
  end

  def get_tracks(user:, limit:, from:, to:)
    @session.user.get_recent_tracks(user, limit, nil, to, from)
  end

  private

  def get_session
    Lastfm.new(ScrobbleService::API_KEY, ScrobbleService::SECRET)
  end

end
