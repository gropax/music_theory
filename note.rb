
module Music

  module Cyclic

    NOTES = { 'C' => 0, 'D' => 2, 'E' => 4, 'F' => 5, 'G' => 7, 'A' => 9, 'B' => 11 }

    SYMBOLS = {'#' => 1, 'b' => -1, nil => 0}

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
        major_thirteenth: 21,
    }


    class Note

      attr_reader :code

      NoteStringError = Class.new(StandardError)

      def initialize(param)
        if param.is_a? Integer
          @code = param % 12
        elsif param.is_a? String
          if param =~ /[A-G][#b]?/
            note, mod = param.split(//)
            @code = NOTES[note] + SYMBOLS[mod]
          else
            raise NoteStringError, "Invalid note string #{param}"
          end
        else
          raise TypeError, "Take Integer or String but found: #{param.class}"
        end
      end

      def ==(other)
        if @code == other.code
          true
        else
          false
        end
      end

      def to_s(printer = NotePrinter.new)
        printer.print @code
      end

      def to_i
        @code
      end

      def +(interval)
        code = (@code + interval.to_i) % 12
        Note.new(code)
      end

      def method_missing(m, *args, &block)
        if INTERVAL_NAMES.include? m
          get_relative(INTERVAL_NAMES[m])
        elsif ScaleFactory.scale m
          ScaleFactory.scale(m).new(self)
        else
          raise NoMethodError, "No method called #{m}"
        end
      end

    end

    Ab = Note.new(8)
    A = Note.new(9)
    Ax = Note.new(10)
    Bb = Note.new(10)
    B = Note.new(11)
    C = Note.new(0)
    Cx = Note.new(1)
    Db = Note.new(1)
    D = Note.new(2)
    Dx = Note.new(3)
    Eb = Note.new(3)
    E = Note.new(4)
    F = Note.new(5)
    Fx = Note.new(6)
    Gb = Note.new(6)
    G = Note.new(7)


    class NotePrinter
      attr_reader :mode

      OutputModeError = Class.new(StandardError)

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

      def print(note_code)
        if NOTES.has_value? note_code
          NOTES.key(note_code)
        else
          if @mode == :sharp
            "#{NOTES.key(note_code - 1)}#"
          elsif @mode == :flat
            "#{NOTES.key(note_code + 1)}b"
          end
        end
      end

    end

  end

end
