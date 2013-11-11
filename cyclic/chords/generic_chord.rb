module Music
  module Cyclic
    # Class that model a generic chord pattern (like major 7th, or dominant 7th)
    #
    # @example
    #   # Create a new GenericChord
    #   dominant_7th = GenericChord.new('Dominant seventh', '7', [0, 4, 7, 10])
    #   # Create a new real Chord from it
    #   a_dominant_7th = dominant_7th.of(A)
    #
    # @todo Delete the initialization from the HasInterval object
    #
    class GenericChord
      include HasIntervals
      attr_reader :name, :abbrev, :intervals, :scale

      def initialize(name, abbrev, param)
        @name, @abbrev = name, abbrev
        if param.is_a? Array
          @intervals = intervals.map { |i| Interval.new(i.to_i) }.uniq
        elsif param.respond_to? :intervals
          @scale = param
          @intervals = [0, 2, 4, 6].map { |i| @scale.intervals[i] }
        else
          raise TypeError, 'Invalid parameter found'
        end
      end
    end
  end
end