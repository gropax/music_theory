require_relative 'note'

module Music
  module Absolute
    class NoteIO
      NoteStringError = Class.new(StandardError)

      def initialize
        @cyclic_note_io = Cyclic::NoteIO.new
      end

      def mode
        @cyclic_note_io.mode
      end

      def flat
        @cyclic_note_io.flat
        self
      end

      def sharp
        @cyclic_note_io.sharp
        self
      end

      def note_value(string)
        note_str = string.dup
        if note_str =~ /[A-G][#b]?([1-9]|10)$/
          octave = note_str.slice!(/(\d*)$/).to_i
          begin
            cyclic_value = @cyclic_note_io.note_value(note_str)
          rescue Cyclic::NoteIO::NoteStringError
            raise NoteStringError, "Invalid note string #{string}"
          end
          cyclic_value + 12 * octave
        else
          raise NoteStringError, "Invalid note string #{string}"
        end
      end

      def print(note_value)
        octave = note_value / 12
        cyclic_str = @cyclic_note_io.print(note_value % 12)
        cyclic_str + octave.to_s
      end
    end
  end
end
