module Music
  module Cyclic
    class Chord
      include HasNotes
      attr_reader :notes, :generic_chords

      def initialize(notes, chord_interpreter = ChordInterpreter.new)
        @notes = notes.map { |n| Note.new(n.to_i) }.uniq
        @generic_chords = chord_interpreter.interpret(@notes)
      end
    end
  end
end