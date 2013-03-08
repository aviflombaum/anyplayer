require "test_helper"

class FakeVoterSelector
  prepend Anyplayer::Voter::Selector

  def player
    Noplayer.new
  end
end

class VoterSelectorTest < MiniTest::Unit::TestCase
  def test_player
    selector = FakeVoterSelector.new
    player = selector.player
    assert_kind_of Player, player
    assert player.respond_to?(:vote), "player should have vote method"
  end
end
