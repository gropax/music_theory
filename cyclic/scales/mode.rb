module Music
  module Cyclic
    # Class modeling a mode of a particular scales in a particular key.
    #
    # @todo
    #   Refactor #notes using Array#dup
    #
    class Mode
      include HasNotes
      attr_reader :notes, :scale, :generic_mode, :root

      def initialize(scale, generic_mode, root)
        @scale, @generic_mode = scale, generic_mode
        # Create the notes array from the generic mode's intervals
        @notes = generic_mode.intervals.map { |int| root + int }
        @root = @notes.first
      end

      def key
        @scale.root
      end

      def to_s
        @generic_mode.inspect + " of #{@root}"
      end
      alias_method :inspect, :to_s

      # Delegate unknown methods to @generic_mode
      #
      # @todo Add a #respond_to_missing? method
      #
      def method_missing(method, *args, &block)
        if @generic_mode.respond_to? method
          @generic_mode.send(method, *args, &block)
        else
          super
        end
      end
    end
  end
end
