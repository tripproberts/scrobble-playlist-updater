class Track
  attr_accessor :artist, :artist_mbid, :mbid, :name

  def initialize(artist, artist_mbid, mbid, name)
    @artist = artist
    @artist_mbid = artist_mbid
    @mbid = mbid
    @name = name
  end

  def ==(other)
    @artist == other.artist && @artist_mbid == other.artist_mbid && @mbid == other.mbid && @name == other.name
  end

  def eql?(other)
    self == other
  end

  def hash
    [@artist, @artist_mbid, @mbid, @name].hash
  end

  def to_s
    "#{@artist} - #{@name}"
  end

  def to_spotify_query
    "artist:#{@artist} track:#{@name}".gsub("'", "")
  end
end
