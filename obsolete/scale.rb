require_relative 'note'
require_relative 'interval'


module Music

  module Cyclic

    RelativeNoteError = Class.new(StandardError)

    class AbstractScale
      attr_reader :name, :intervals

      def initialize(name = 'unknown', intervals)
        @name = name
        @intervals = intervals.map do |i|
          if i.is_a? Integer
            Interval.new(i)
          elsif i.is_a? Interval
            i
          else
            raise TypeError, "Expected Integer or Interval but found: #{i.class}"
          end
        end
      end

      def has?(symbol)
        if INTERVAL_NAMES.has_key? symbol
          @intervals.include? INTERVAL_NAMES[symbol]
        else
          raise RelativeNoteError, "Unknown relative note: #{symbol}"
        end
      end

      def to_s
        "The #{@name.capitalize}"
      end

    end

    MAJOR_SCALE = AbstractScale.new 'Major Scale', [ 0, 2, 3, 5, 7, 9, 11 ]


    class Scale
      attr_reader :key, :notes

      def initialize(scale, key)
        @scale = scale
        @key = key
        @notes = @scale.intervals.map { |interval| key + interval }.uniq

      end

      def include?(note)
        if @notes.include?(note)
          true
        else
          false
        end
      end

      def count
        @notes.size
      end

      def to_s
        "The #{@key} #{@scale.name.capitalize}"
      end

    end

  end

end