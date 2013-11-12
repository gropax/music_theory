require_relative 'music'
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

  def size
    @holes.size
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

    def initialize(key, number, airflow)
      @number = number
      @airflow = [:blow, :draw].map do |side|
        # Create regular note
        reg = key + airflow[side][:regular]
        af_ary = [] << Airflow.new(self, reg, side, :regular)
        # Create altered notes if any
        if (alt_ary = notes[side][:alter])
          type, *alts = alt_ary
          af_ary << alts.map { |alt| Airflow.new(self, reg, side, type, alt) }
        end
        af_ary
      end.flatten
    end

    def play(side, alter = 0)
      afs = @airflow.select { |af| af.side == side && af.alter == alter }
      if afs.empty?
        raise AlterationError, "No #{alter} #{side} alteration on hole #{@number}"
      else
        afs.first
      end
    end

    def blow(alter = 0)
      play(:blow, alter)
    end

    def draw(alter = 0)
      play(:draw, alter)
    end

    def get(note)
      case note
        when Cyclic::Note
          @airflow.select { |af| af.note.cyclic == note }
        when Absolute::Note
          @airflow.select { |af| af.note == note }
        else
          raise TypeError, "invalid type: #{note.class}"
      end
    end
  end

  class Airflow
    attr_reader :hole, :note, :side, :type, :alter

    def initialize(hole, base, side, type, alter = 0)
      @note = Absolute::Note.new(base + alter)
      @hole, @side, @type, @alter = hole, side, type, alter
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