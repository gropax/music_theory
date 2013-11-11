module Music
  module Cyclic
    # Class modeling a scales in a particular root.
    #
    class Scale
      include HasNotes
      attr_reader :notes, :modes, :generic_scale, :root
      # Guarantying that scale and mode share the same interface
      alias_method :root, :key

      def initialize(generic_scale, root)
        @generic_scale, @root = generic_scale, root
        # Creat the notes array from the generic scale's intervals
        @notes = generic_scale.intervals.map { |int| root + int }
        # Initialize the modes from the generic scales modes
        generic_scale.modes.each_index do |i|
          (@modes ||= []) << Mode.new(self, generic_scale.modes[i], @notes[i])
        end
      end

      def to_s
        @generic_scale.inspect + " of #{@root}"
      end
      alias_method :inspect, :to_s

      # Delegate missing method to @generic_scale
      #
      # @todo Add a #respond_to_missing? method
      #
      def method_missing(method, *args, &block)
        if @generic_scale.respond_to? method
          @generic_scale.send(method, *args, &block)
        else
          super
        end
      end
    end
  end
end
