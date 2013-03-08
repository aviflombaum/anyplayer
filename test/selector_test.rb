require "test_helper"

class SelectorTest < MiniTest::Unit::TestCase
  include FlexMock::TestCase

  def test_selector_player
    selector = Selector.new
    player = selector.player
    assert_kind_of Player, player
  end

  def test_verbose_accessor
    selector = Selector.new
    assert !selector.verbose

    selector.verbose = true
    assert selector.verbose
  end

  def test_verbose_flag_messages
    selector = Selector.new
    selector.verbose = true

    assert_output nil, "Loaded noplayer\nNoplayer launched?\n" do
      selector.player
    end
  end

  def test_none_launched
    selector = Selector.new
    flexmock(Noplayer).new_instances.should_receive(:launched?).returns(false)
    assert_nil selector.player
  end

  def test_timeout
    flexmock(Noplayer).new_instances.should_receive(:launched?).returns { sleep 50; true }

    Selector.stub_const(:TIMEOUT_SECONDS, 0.005) do
      selector = Selector.new
      selector.verbose = true

      assert_output "", /Timed out after 0.005 seconds/ do
        assert_nil selector.player
      end
    end
  end

  def test_player_load_error
    Anyplayer.stub_const(:PLAYERS, ['whizz']) do
      selector = Selector.new
      selector.verbose = true

      assert_output "", "Could not load whizz\n" do
        assert_nil selector.player
      end
    end
  end
end
