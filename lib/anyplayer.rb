module Anyplayer
  # List and order of the players to try
  PLAYERS = %w(
    rhythmbox
    mpd
    xmms2
    amarok
    itunes_mac
    itunes_windows
    spotify_mac
  )

  def self.launched
    $stderr.puts "Anyplayer.launched is deprecated: please initialize a new Selector and call player"
    Selector.new.player
  end
end

require "anyplayer/version"
require "anyplayer/player"
require "anyplayer/selector"

require "anyplayer/voter/voter"
require "anyplayer/cacher/selector"
require "anyplayer/base_selector"
