require "test_helper"

class BinTest < MiniTest::Unit::TestCase
  include FlexMock::TestCase

  def test_usage
    usage = <<USAGE
Usage: #{$0} [-v] [command]

Where command is one of: playpause, play, pause, next, prev, voldown, volup,
volume, track, artist, album, name, launched.

Player connected: Noplayer.
USAGE

    assert_output usage do
      assert_exists_with_status(1) do
        load 'bin/anyplayer'
      end
    end

    with_argv %w(foobar) do
      assert_output usage do
        assert_exists_with_status(1) do
          load 'bin/anyplayer'
        end
      end
    end
  end

  def test_no_player
    flexmock(Noplayer).new_instances.should_receive(:launched?).returns(false)
    assert_bin_anyplayer(argv: %w(artist), exit: 1, error_output: "Error: no player connected.\n")

    assert_bin_anyplayer(argv: %w(-v artist), exit: 1,
      error_output: "Loaded noplayer\nNoplayer launched?\nError: no player connected.\n")
  end

  def test_artist
    assert_bin_anyplayer(argv: %w(artist), output: "The Drums\n")

    assert_bin_anyplayer(argv: %w(-v artist), output: "The Drums\n",
      error_output: "Loaded noplayer\nNoplayer launched?\n")
  end

  def test_playpause
    assert_bin_anyplayer(argv: %w(playpause))
  end

  def test_play
    assert_bin_anyplayer(argv: %w(play))
  end

  def test_pause
    assert_bin_anyplayer(argv: %w(pause))
  end

  def test_next
    assert_bin_anyplayer(argv: %w(next))
  end

  def test_prev
    assert_bin_anyplayer(argv: %w(prev))
  end

  def test_voldown
    assert_bin_anyplayer(argv: %w(voldown))
  end

  def test_volup
    assert_bin_anyplayer(argv: %w(volup))
  end

  def test_volume
    assert_bin_anyplayer(argv: %w(volume), output: "100\n")
  end

  def test_track
    assert_bin_anyplayer(argv: %w(track), output: "Money\n")
  end

  def test_artist
    assert_bin_anyplayer(argv: %w(artist), output: "The Drums\n")
  end

  def test_album
    assert_bin_anyplayer(argv: %w(album), output: "Money\n")
  end

  def test_name
    assert_bin_anyplayer(argv: %w(name), output: "Noplayer\n")
  end

  def test_launched
    assert_bin_anyplayer(argv: %w(launched))
  end

  def test_playing
    assert_bin_anyplayer(argv: %w(playing))
  end

  def test_paused
    assert_bin_anyplayer(argv: %w(paused), exit: 1)
  end

  private

    def assert_bin_anyplayer(argv: nil, exit: 0, output: "", error_output: "")
      assert_output output, error_output do
        assert_exists_with_status(exit) do
          with_argv argv do
            load 'bin/anyplayer'
            yield if block_given?
          end
        end
      end
    end

    def assert_exists_with_status(status)
      begin
        yield
      rescue SystemExit => e
        assert_equal status, e.status, "SystemExit with status expected"
        return
      end

      flunk "SystemExit expected to be raised." if status != 0
    end

    # Replace ARGV temporarily in the given block
    def with_argv(argv)
      original_argv = ARGV.dup
      ARGV.replace argv
      yield
    ensure
      ARGV.replace original_argv
    end

end
