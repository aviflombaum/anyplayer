class Anyplayer::VoterSelector < Anyplayer::Selector
  def player
    player = super
    player.extend Anyplayer::Voter if player
    player
  end
end
