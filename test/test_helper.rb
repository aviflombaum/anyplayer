# Test libraries
require "minitest/unit"
require "minitest/autorun"
require "minitest/stub_const"
require "flexmock/test_unit"

# Anyplayer with the testing noplayer first
require "anyplayer"
require "anyplayer/players/noplayer"
Anyplayer::PLAYERS.replace ["noplayer"]

include Anyplayer
