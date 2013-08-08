
module Music
  module Cyclic

    class Note
      attr_reader :value

      def initialize(param, note_io = NoteIO.new)
        @note_io = note_io
        if param.is_a? String
          @value = @note_io.note_value(param)
        elsif param.respond_to? :to_i
          @value = param.to_i % 12
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

      def to_i
        @value
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


    class NoteIO
      attr_reader :mode

      NOTES = { 'C' => 0, 'D' => 2, 'E' => 4, 'F' => 5, 'G' => 7, 'A' => 9, 'B' => 11 }
      SYMBOLS = {'#' => 1, 'b' => -1, nil => 0}

      OutputModeError = Class.new(StandardError)
      NoteStringError = Class.new(StandardError)

      def initialize
        @mode = :sharp
      end

      def flat
        @mode = :flat
        self
      end

      def sharp
        @mode = :sharp
        self
      end

      def note_value(string)
        if string =~ /[A-G][#b]?/
          note, mod = string.split(//)
          (NOTES[note] + SYMBOLS[mod]) % 12
        else
          raise NoteStringError, "Invalid note string #{param}"
        end
      end

      def print(note_value)
        if NOTES.has_value? note_value
          NOTES.key(note_value)
        else
          if @mode == :sharp
            "#{NOTES.key(note_value - 1)}#"
          elsif @mode == :flat
            "#{NOTES.key(note_value + 1)}b"
          end
        end
      end

    end

  end
end
