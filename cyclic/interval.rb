module Music
  module Cyclic
    class Interval
      def initialize(param, interval_io = IntervalIO.new)
        @interval_io = interval_io
        if param.respond_to? :to_str
          @value = @note_io.interval_value(param.to_str)
        elsif param.respond_to? :to_i
          @value = param.to_i % 12
        else
          raise TypeError, "Wrong type: #{param.class}"
        end
      end

      def ==(other)
        @value == other.to_i
      end

      def to_s
        @interval_io.print @value
      end
      alias_method :inspect, :to_s

      def to_int
        @value
      end
      alias_method :to_i, :to_int

      def +(other)
        value = (@value + other.to_i) % 12
        Interval.new(value)
      end

      def -(other)
        value = (@value - other.to_i) % 12
        Interval.new(value)
      end
    end
  end
end