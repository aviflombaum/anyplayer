class Anyplayer::SpotifyMac < Anyplayer::Player
  def playpause
    app 'playpause'
  end

  def play
    app 'play'
  end

  def prev
    app 'previous track'
    super
  end

  def next
    app 'next track'
    super
  end

  def voldown
    app 'set sound volume to sound volume - 10'
  end

  def volup
    app 'set sound volume to sound volume + 10'
  end

  def volume
    app 'return sound volume'
  end

  def track
    app 'return name of current track'
  end

  def artist
    app 'return artist of current track'
  end

  def album
    app 'return album of current track'
  end

  def launched?
    nb = %x(osascript -e 'tell app "System Events" to count (every process whose name is "Spotify")' 2>/dev/null).rstrip
    nb.match(/^\d+/) and nb.to_i > 0 ? true : false
  end

  private
    def app(command)
      %x(osascript -e 'tell app "Spotify" to #{command}').rstrip
    end
end
