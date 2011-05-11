module Anyplayer
  class Amarok < Player
    def playpause
      tell_to 'PlayPause'
    end

    def prev
      tell_to 'Prev'
      super
    end

    def next
      tell_to 'Next'
      super
    end

    def voldown
      tell_to 'VolumeDown 5'
    end

    def volup
      tell_to 'VolumeUp 5'
    end

    def volume
      tell_to 'VolumeGet'
    end

    def track
      get_metadata('title')
    end
    
    def artist
      get_metadata('artist')
    end
    
    def album
      get_metadata('album')
    end

    def launched?
      not %x(qdbus org.kde.amarok 2>&1).match(/does not exist|command not found/)
    end

    private
    def tell_to(command)
      %x(qdbus org.kde.amarok /Player org.freedesktop.MediaPlayer.#{command}).rstrip
    end

    def get_metadata(name)
      tell_to('GetMetadata').match(/#{name}: (\S.*)/)[1] rescue nil
    end
  end
end

