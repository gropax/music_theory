require_relative 'interval'

module Music
  module Cyclic
    # @todo rename to INTERVALS
    INTERVAL_NAMES = {
        unison: 0,
        minor_second: 1,
        major_second: 2,
        minor_third: 3,
        major_third: 4,
        perfect_fourth: 5,
        augmented_fourth: 6,
        diminished_fifth: 6,
        perfect_fifth: 7,
        minor_sixth: 8,
        major_sixth: 9,
        minor_seventh: 10,
        major_seventh: 11,
        octave: 12,
        minor_ninth: 13,
        major_ninth: 14,
        perfect_eleventh: 17,
        augmented_eleventh: 18,
        minor_thirteenth: 20,
        major_thirteenth: 21
    }

    class IntervalIO
      IntervalStringError = Class.new(StandardError)

      # @todo
      #   - Clean the name identification
      #   - Change the name to #interval
      #
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