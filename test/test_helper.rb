# Test libraries
require "minitest/unit"
require "minitest/autorun"
require "flexmock/test_unit"


# Anyplayer with the testing noplayer first
require "anyplayer"

require "anyplayer/players/noplayer"
Anyplayer::PLAYERS.unshift "noplayer"

include Anyplayer
