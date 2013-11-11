module Music
  module Cyclic
    module HasIntervals
      def intervals
        raise NotImplementedError, '#intervals method not implemented'
      end

      def ==(other)
        intervals == other.intervals
      end

      def same_intervals?(other)
        self.intervals == other.intervals
      end

      def has_interval?(interval)
        self.intervals.include? interval
      end

      def [](int)
        self.intervals[int.to_i]
      end
    end
  end
end