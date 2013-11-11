module Music
  module Cyclic
    class GenericMode
      include HasIntervals
      attr_reader :scale, :degree, :intervals, :name

      def initialize(scale, degree, name)
        @name, @degree, @scale = name, degree, scale
        # Create the array of intervals from the scales intervals, by modifying them relatively
        # to the new root, and applying the appropriate rotation to begin with the root
        first_int = @scale.intervals[@degree - 1]
        @intervals = @scale.intervals.map { |int| int - first_int }.rotate(@degree - 1)
      end

      # This method is used to create an instance of the associated Mode in the given key. It first
      # calculate the corresponding scales key, then create a new Scale and return the corresponding
      # Mode.
      #
      # @todo refactor the name
      #
      def of(note)
        # Get the key corresponding to the given mode root
        key = Note.new(note.to_i) - @scale.intervals[@degree - 1]
        # Create the scales and return the corresponding mode
        Scale.new(@scale, key).modes[@degree - 1]
      end

      def from_same_scale?(other)
        @scale.modes.each do |m|
          return true if m.same_intervals? other
        end
        false
      end

      def to_s
        if @name == ''
          "The #{@degree} Mode of the #{@scale.name.capitalize} Scale"
        else
          "The #{@name.capitalize} mode"
        end
      end
      alias_method :inspect, :to_s
    end
  end
end
