module Music
  module Cyclic
    class GenericScale
      include HasIntervals
      attr_reader :modes, :intervals, :name

      def initialize(name, intervals, mode_names)
        @name = name
        # Initialize the array of intervals from the given ones
        @intervals = intervals.map { |i| Interval.new(i.to_i) }.uniq
        # For each of them, initialize the corresponding Mode
        @intervals.each_index do |i|
          (@modes ||= []) << GenericMode.new(self, i + 1, mode_names[i])
        end
      end

      # This method return an instance of the associated Scale in the given key
      #
      def of(note)
        Scale.new(self, Note.new(note.to_i))
      end

      def from_same_scale?(other)
        @modes.each do |m|
          return true if m.same_intervals? other
        end
        false
      end

      def to_s
        "The #{name.capitalize} Scale"
      end
      alias_method :inspect, :to_s
    end
  end
end