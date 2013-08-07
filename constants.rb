require_relative 'note'
require_relative 'interval'
require_relative 'scale'


module Music::Cyclic

  # Notes Constants
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
  Gx = Note.new(8)
  Ab = Note.new(8)

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
      major_thirteenth: 21
  }

  # Scales
  MAJOR_SCALE = GenericScale.new('major', [0, 2, 4, 5, 7, 9, 11], %w(ionian dorian phrygian lydian mixolydian eolian locrian))
  PENTATONIC_SCALE = GenericScale.new('pentatonic', [0, 2, 4, 7, 9], ['major','','','','minor'])
  SCALES = {
      major_scale: MAJOR_SCALE,
      pentatonic: PENTATONIC_SCALE,
  }

  MODES = {
      # Major scale
      ionian: MAJOR_SCALE.modes[0],
      dorian: MAJOR_SCALE.modes[1],
      phrygian: MAJOR_SCALE.modes[2],
      lydian: MAJOR_SCALE.modes[3],
      mixolydian: MAJOR_SCALE.modes[4],
      eolian: MAJOR_SCALE.modes[5],
      locrian: MAJOR_SCALE.modes[6],
      # Pentatonic scale
      major_pentatonic: PENTATONIC_SCALE.modes[0],
      minor_pentatonic: PENTATONIC_SCALE.modes[4],

  }




end

