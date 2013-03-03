# A Fake player for tests
class Anyplayer::Noplayer < Anyplayer::Player
  def playpause
  end

  def play
  end

  def pause
  end

  def prev
  end

  def next
  end

  def voldown
  end

  def volup
  end

  def volume
    100
  end

  def track
    "Money"
  end

  def artist
    "The Drums"
  end

  def album
    "Money"
  end

  def launched?
    true
  end
end

