require_relative 'scrobble_service'
require_relative 'scrobble'

class ScrobbleUser
  def self.fetch_scrobbles(username, limit: 200, from:, to: Time.now)
    responses = ScrobbleService.new.get_tracks(user: username, limit: limit, from: from.to_i, to: to.to_i)
    responses = [responses] if responses.is_a? Hash
    responses.nil? ? [] : responses.map { |r|
      Scrobble.build_from_service(r)
    }.compact
  end

end
