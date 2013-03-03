require "test_helper"

class AnyplayerTest < MiniTest::Unit::TestCase
  def test_player
    selector = VoterSelector.new
    player = selector.player
    assert_kind_of Player, player
    assert player.respond_to?(:vote)
  end
end
