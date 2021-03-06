require 'shoes/timer_base'

module Shoes
  module Swt
    module Animation
      def gui_init
        # Wrap the animation block so we can count frames.
        # Note that the task re-calls itself on each run.
        task = Proc.new do
          unless @app.gui_container.disposed?
            @blk.call(@current_frame)
            @current_frame += 1
            @app.gui_container.redraw
            ::Swt.display.timer_exec (2000 / @framerate), task
          end
        end
        ::Swt.display.timer_exec (2000 / @framerate), task
      end

      #def stop
      #end

      #def start
      #end
    end
  end
end

module Shoes
  class Animation
    include Shoes::Swt::Animation
  end
end
