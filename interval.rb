
module Music
  module Cyclic

    class Interval
      attr_reader :value

      def initialize(param, interval_io = IntervalIO.new)
        @interval_io = interval_io
        if (param.is_a? String) || (param.is_a? Symbol)
          @value = @note_io.interval_value(param.to_s)
        elsif param.respond_to? :to_i
          @value = param.to_i % 12
        else
          raise TypeError, "Wrong type: #{param.class}"
        end
      end

      def ==(other)
        @value == other.to_i
      end

      def +(other)
        value = (@value + other.to_i) % 12
        Interval.new(value)
      end

      def -(other)
        value = (@value - other.to_i) % 12
        Interval.new(value)
      end

      def to_s
        @interval_io.print @value
      end

      def to_i
        @value
      end

    end


    class IntervalIO
      IntervalStringError = Class.new(StandardError)

      def interval_value(string)
        if INTERVAL_NAMES.include? string
          INTERVAL_NAMES[string]
        else
          raise IntervalError, "Invalid interval #{string}"
        end
      end

      def print(interval_value)
        "The #{INTERVAL_NAMES.key(interval_value).to_s.sub(/_/, ' ').capitalize}'s Interval"
      end

    end

  end
end