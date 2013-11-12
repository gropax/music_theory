require 'rspec'
require 'music'

module Music
  module Absolute
    describe NoteIO do
      describe 'string to note conversion' do
        it 'converts valid string into note value' do
          note_io = NoteIO.new
          expect(note_io.note_value('C4')).to eq(48)
          expect(note_io.note_value('F#6')).to eq(78)
          expect(note_io.note_value('Ab2')).to eq(32)
          expect(note_io.note_value('G10')).to eq(127)
        end

        it 'raises exceptions on invalid string' do
          note_io = NoteIO.new
          expect { note_io.note_value('Cb') }.to raise_error(NoteIO::NoteStringError)
          expect { note_io.note_value('Gb12') }.to raise_error(NoteIO::NoteStringError)
          expect { note_io.note_value('Dbb5') }.to raise_error(NoteIO::NoteStringError)
        end
      end

      describe 'note value to string' do
        it 'converts a note value to a note string' do
          note_io = NoteIO.new
          expect(note_io.print(50)).to eq('D4')
          expect(note_io.print(0)).to eq('C0')
          expect(note_io.print(127)).to eq('G10')
        end

        it 'can switch to sharp' do
          note_io = NoteIO.new
          expect(note_io.sharp).to eq(note_io)
          expect(note_io.mode).to eq(:sharp)
          expect(note_io.print(51)).to eq('D#4')
        end

        it 'can switch to flat mode' do
          note_io = NoteIO.new
          expect(note_io.flat).to eq(note_io)
          expect(note_io.mode).to eq(:flat)
          expect(note_io.print(51)).to eq('Eb4')
        end
      end
    end
  end
end
