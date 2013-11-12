require 'rspec'
require 'harmonica'

class Harmonica
  describe Hole do
    it 'initialize from hash parameter' do
      key = Music::Absolute::Note.new('C4')
      hsh = {
          blow: {regular: 4, alter: [:valve, -1]},
          draw: {regular: 7, alter: [:bend, -1, -2]}
      }
      hole2 = Hole.new(key, 2, hsh)
    end
  end
end
