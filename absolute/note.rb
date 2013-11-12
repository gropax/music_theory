module Music
  module Absolute
    class Note
      NoteRangeError = Class.new(StandardError)

      def self.all
        (0..11).map { |i| Note.new(i) }
      end

      def initialize(param, note_io = NoteIO.new)
        @note_io = note_io
        if param.respond_to? :to_str
          @value = @note_io.note_value(param.to_str)
        elsif param.respond_to? :to_int
          @value = param.to_int
        else
          raise TypeError, "Wrong type: #{param.class}"
        end
        if @value < 0 || @value > 127
          raise NoteRangeError, 'Note value must be in (0..127)'
        end
      end

      def ==(other)
        @value == other.value
      end

      def to_s
        @note_io.print @value
      end
      alias_method :inspect, :to_s

      def to_int
        @value
      end
      alias_method :to_i, :to_int

      def interval_to(note)
        value = note.to_int - @value
        Interval.new(value)
      end

      def +(interval)
        value = @value + interval.to_i
        Note.new(value)
      end

      def -(interval)
        value = @value - interval.to_i
        Note.new(value)
      end
    end
  end
end
