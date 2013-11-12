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

      # @todo Refactor to #note
      #
      def note_value(string)
        if string =~ /[A-G][#b]?([1-9]|10)/
          octave = string.slice!(/(\d*)$/).to_i
          cyclic_value = @cyclic_note_io.note_value(string)
          cyclic_value + 12 * octave
        else
          raise NoteStringError, "Invalid note string #{param}"
        end
      end

      def print(note_value)
        octave = note_value / 12
        cyclic_str = @cyclic_note_io.print(note_value - octave)
        cyclic_str + octave.to_s
      end
    end
  end
end
