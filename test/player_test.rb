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

  def test_playing?
    player = FakePlayer.new
    flexmock(player).should_receive(:track).and_return("Foo")
    assert player.playing?

    player = FakePlayer.new
    flexmock(player).should_receive(:track).and_return("")
    assert !player.playing?
  end

  def test_paused?
    player = FakePlayer.new
    flexmock(player).should_receive(:playing?).and_return(true)
    assert !player.paused?

    player = FakePlayer.new
    flexmock(player).should_receive(:playing?).and_return(false)
    assert player.paused?
  end
end
