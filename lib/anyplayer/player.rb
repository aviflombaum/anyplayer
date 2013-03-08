# Default Player class that is inherrited by all players.
#
# All players should override these methods:
#   launched? (return bool)
#   next
#   prev
#   play
#   pause
#   track     (return string)
#   artist    (return string)
#   album     (return string)
#   voldown
#   volup
#   volume    (return int)
#
# Optionnaly you can also override:
#   playpause
#   playing?  (return bool)
#   paused?   (return bool)
#   name      (return string)

class Anyplayer::Player

  # Tells the player to toggle the pause state
  def playpause
    paused? ? play : pause
  end

  def playing?
    track != ""
  end

  def paused?
    !playing?
  end

  # Player name defaults to the class name
  # Example:
  #     player.name # => Rhythmbox
  def name
    self.class.to_s.gsub(/^.*::/, '')
  end

  def to_h
    { track: track, artist: artist, album: album }
  end

end

