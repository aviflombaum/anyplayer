module Anyplayer::Cacher
  module Selector

    def player
      if @cached_player and @cached_player.launched?
        @cached_player
      else
        @cached_player = super
      end
    end

    private

      def each_instance(&block)
        if !@cached_instances
          @cached_instances = []
          super { |instance| @cached_instances << instance }
        end
        @cached_instances.each(&block)
      end

  end
end
