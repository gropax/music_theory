
module Music

  module Cyclic

    class Interval

      attr_reader :semitones

      IntervalError = Class.new(StandardError)

      def initialize(param)
        if param.is_a? Integer
          @semitones = param
        elsif param.is_a? Symbol
          if INTERVAL_NAMES.include? param
            @semitones = INTERVAL_NAMES[param]
          else
            raise IntervalError, "Invalid interval #{param}"
          end
        else
          raise TypeError, "Take Integer or Symbol but found: #{param.class}"
        end
      end

      def ==(other)
        @semitones == other.to_i
      end

      def +(other)
        semitones = (@semitones + other.to_i) % 12
        Interval.new(semitones)
      end

      def -(other)
        semitones = (@semitones - other.to_i) % 12
        Interval.new(semitones)
      end

      def to_s
        "The #{INTERVAL_NAMES.key(@semitones).to_s.sub(/_/, ' ').capitalize}'s Interval"
      end

      def to_i
        @semitones
      end

    end

  end

end