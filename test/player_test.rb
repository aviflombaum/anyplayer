require "test_helper"

class FakePlayer < Anyplayer::Player
end

class PlayerTest < MiniTest::Unit::TestCase
  include FlexMock::TestCase

  def test_name
    assert_equal "FakePlayer", FakePlayer.new.name
  end

  def test_playpause
    player = FakePlayer.new
    flexmock(player).should_receive(:paused?).and_return(true)
    flexmock(player).should_receive(:play).once
    player.playpause

    player = FakePlayer.new
    flexmock(player).should_receive(:paused?).and_return(false)
    flexmock(player).should_receive(:pause).once
    player.playpause
  end
end
