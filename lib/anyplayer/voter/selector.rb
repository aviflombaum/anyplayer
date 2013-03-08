# A Selector that returns vote-able players
module Anyplayer::Voter::Selector
  def player
    player = super
    player.extend(Anyplayer::Voter::Player) if player
    player
  end
end
