require "test_helper"

class FakePlayer < Player
  def next; end
  def prev; end
end

class VoterTest < MiniTest::Unit::TestCase
  include FlexMock::TestCase

  def setup
    @player = FakePlayer.new
    @player.extend Anyplayer::Voter
  end

  def test_initialize
    assert_equal 0, @player.votes
  end

  def test_vote_and_votes
    votes = Anyplayer::Voter::DEFAULT_VOTES_TO_SKIP
    votes.times do |i|
      @player.vote

      # votes should be 0 if we've voted enough times
      if i == votes - 1
        assert_equal @player.votes, 0
      else
        assert_equal @player.votes, i + 1
     end
    end
  end

  def test_voting_changes_track
    flexmock(@player).should_receive(:next).once
    Anyplayer::Voter::DEFAULT_VOTES_TO_SKIP.times { @player.vote }
  end

  def test_vote_resets
    @player.vote
    @player.next
    assert_equal 0, @player.votes

    @player.vote
    @player.prev
    assert_equal 0, @player.votes
  end

  def test_custom_voting_quota
    10.times do |i|
      @player.vote(10)

      if i == 9
        assert_equal @player.votes, 0
      else
        assert_equal @player.votes, i + 1
     end
    end
  end


end
