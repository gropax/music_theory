module Music
  module Cyclic
    class Note
      def self.all
        (0..11).map { |i| Note.new(i) }
      end

      def initialize(param, note_io = NoteIO.new)
        @note_io = note_io
        if param.respond_to? :to_str
          @value = @note_io.note_value(param.to_str)
        elsif param.respond_to? :to_int
          @value = param.to_int % 12
        else
          raise TypeError, "Wrong type: #{param.class}"
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

      def interval_up_to(note)
        value = note.to_i - @value % 12
        Interval.new(value)
      end

      def interval_down_to(note)
        value = @value - note.to_i % 12
        Interval.new(value)
      end

      def +(interval)
        value = (@value + interval.to_i) % 12
        Note.new(value)
      end

      def -(interval)
        value = (@value - interval.to_i) % 12
        Note.new(value)
      end
    end
  end
end
