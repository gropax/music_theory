require_relative 'music_theory'
# Class that models a diatonic harmonica
#
# @example
#   # Create a new Harmonica object
#   harp = Harmonica.new(C) #=> <Harmonica C >

#   # Get notes from specific hole and airflow
#   harp[4].blow #=> <Absolute::Note C4 >
#   harp[4].draw #=> <Absolute::Note D4 >
#   harp[4].draw(:bend, -1) #=> <Absolute::Note Db4 >
#   harp[4].blow(:valve, -1) #=> <Absolute::Note Cb4 >

#   # Get holes and airflow from an absolute note
#   harp.get(D4) #=> [[4, :draw, :regular]]
#   harp.get(G3) #=> [[2, :draw, :regular], [3, :blow, :regular]]
#   harp.get(Db4) #=> [[4, :draw, :bend, -1]]

#   # Get holes and airflow from a cyclic note
#   harp.get(C) #=> [ [1, :blow, :regular], [4, :blow, :regular], ... ]
#                  or { <Absolute::Note C2 > => [1, :blow, :regular], ... }
#
class Harmonica
  include Music
  attr_reader :key

  def initialize(key, tuning = STANDARD_VALVED)
    if STANDARD_KEYS.include? key
      @key = STANDARD_KEYS[key]
    else
      raise KeyError, "No standard key: #{key}"
    end
    tuning.each_pair do |k, v|
      (@holes ||= []) << Hole.new(@key, k, v)
    end
  end

  def [](i)
    @holes[i-1]
  end

  def get(note)
    notes = []
    @holes.each_with_index do |h, i|
      notes << h.get(note)
    end
    notes.flatten
  end

  # Class that model a hole of an harmonica
  # 
  # Initialization hash for hole 2:
  #   {
  #     blow: { regular: 4, alter: [:valve, -1] },
  #     draw: { regular: 7, alter: [:bend, -1, -2] }
  #   }
  class Hole
    AlterationError = Class.new(StandardError)

    def initialize(key, number, notes)
      @number = number
      @notes = {blow: [], draw: []}
      @notes.each_pair do |k, v|
        # Create regular note
        reg = key + notes[k][:regular]
        v << Note.new(@number, reg, :regular)
        # Create altered notes if any
        if (alt_ary = notes[k][:alter])
          type, *alts = alt_ary
          v += alts.map { |alt| Note.new(@number, reg, type, alt) }
        end
      end
    end

    def blow(alter = 0)
      @notes[:blow][alter.abs]
    end

    def draw(alter = 0)
      @notes[:draw][alter.abs]
    end

    def get(note)
      case note
        when Cyclic::Note
          @notes.select { |n| n.cyclic == note }
        when Absolute::Note
          @notes.select { |n| n == note }
        else
          raise TypeError, "invalid type: #{note.class}"
      end
    end
  end

  class Note < Absolute::Note
    attr_reader :airflow, :alter

    def initialize(number, base, airflow, alter = 0)
      super(base + alter)
      @number, @airflow, @alter = number, airflow, alter
    end
  end

  # @todo
  #   Check the right position of the F# key
  STANDARD_KEYS = {
      'lowF' => Absolute::Note.new('F3'),
      'G' => Absolute::Note.new('G3'),
      'Ab' => Absolute::Note.new('Ab3'),
      'A' => Absolute::Note.new('A3'),
      'Bb' => Absolute::Note.new('Bb3'),
      'B' => Absolute::Note.new('B3'),
      'C' => Absolute::Note.new('C4'),
      'Db' => Absolute::Note.new('Db4'),
      'D' => Absolute::Note.new('D4'),
      'Eb' => Absolute::Note.new('Eb4'),
      'E' => Absolute::Note.new('E4'),
      'F' => Absolute::Note.new('F4'),
      'F#' => Absolute::Note.new('F#4'),
      'highG' => Absolute::Note.new('G4')
  }

  STANDARD_VALVED = {
      1 => {
          blow: {regular: 0, alter: [:valve, -1]},
          draw: {regular: 2, alter: [:bend, -1]}
      },
      2 => {
          blow: {regular: 4, alter: [:valve, -1]},
          draw: {regular: 7, alter: [:bend, -1, -2]}
      },
      3 => {
          blow: {regular: 7, alter: [:valve, -1]},
          draw: {regular: 11, alter: [:bend, -1, -2, -3]}
      },
      4 => {
          blow: {regular: 12, alter: [:valve, -1]},
          draw: {regular: 14, alter: [:bend, -1]}
      },
      5 => {
          blow: {regular: 16, alter: [:valve, -1]},
          draw: {regular: 17}
      },
      6 => {
          blow: {regular: 19, alter: [:valve, -1]},
          draw: {regular: 21, alter: [:bend, -1]}
      },
      7 => {
          blow: {regular: 24},
          draw: {regular: 23, alter: [:valve, -1]}
      },
      8 => {
          blow: {regular: 28, alter: [:bend, -1]},
          draw: {regular: 26, alter: [:valve, -1]}
      },
      9 => {
          blow: {regular: 31, alter: [:bend, -1]},
          draw: {regular: 29, alter: [:valve, -1]}
      },
      10 => {
          blow: {regular: 36, alter: [:bend, -1, -2]},
          draw: {regular: 33, alter: [:valve, -1]}
      },
  }
end