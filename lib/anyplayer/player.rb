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
#   playing?  (return bool)
#   paused?   (return bool)
#
# Optionnaly you can also override:
#   playpause
class Anyplayer::Player
  # Player name defaults to the classe's, feel free to override it
  # Example:
  #     player.name # => Rhythmbox
  def name
    self.class.to_s.gsub(/^.*::/, '')
  end

  # Tells the player to toggle the pause state
  def playpause
    paused? ? play : pause
  end
end

