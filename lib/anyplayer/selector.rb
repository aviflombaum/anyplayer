require "timeout"

# The Selector lets you find the currently running player on your platform
#
# Example:
#
#   selector = Anyplayer::Selector.new
#   player = selector.player
#
# Needs the PLAYERS constant containing the list of players to load.

class Anyplayer::Selector
  TIMEOUT_SECONDS = 5

  attr_accessor :verbose
  attr_reader :errors
  include Enumerable

  def initialize
    @verbose = false
    @errors = []
  end

  # Returns an instance of the first music player that's launched
  def player
    first
  end

  private

    def each
      each_instance do |instance|
        yield instance if instance_launched?(instance)
      end
    end

    def each_instance
      each_loaded_player do |player|
        yield player_class(player).new
      end
    end

    def each_loaded_player
      players_for_this_platform.each do |player|
        yield player if player_load(player)
      end
    end

    def players_for_this_platform
      players = Anyplayer::PLAYERS
      players.reject! { |player| player =~ /_mac$/ } if RUBY_PLATFORM !~ /darwin/
      players.reject! { |player| player =~ /_windows$/ } if RUBY_PLATFORM !~ /cygwin|mswin|mingw|bccwin|wince|emx/
      players
    end

    def player_load(player)
      begin
        require "anyplayer/players/#{player}"
        $stderr.puts "Loaded #{player}" if verbose
        true
      rescue LoadError => e
        $stderr.puts "Could not load #{player}" if verbose
        @errors << "Error loading #{player}: #{e.message}"
        false
      end
    end

    def player_class(player)
      camelized = player.to_s.split(/_/).map{ |word| word.capitalize }.join
      Anyplayer::const_get(camelized)
    end

    def instance_launched?(player)
      $stderr.puts "#{player.name} launched?" if verbose

      begin
        Timeout::timeout(TIMEOUT_SECONDS) { player.launched? }
      rescue Timeout::Error
        $stderr.puts "Timed out after #{TIMEOUT_SECONDS} seconds" if verbose
        false
      end
    end
end
