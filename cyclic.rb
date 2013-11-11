module Music
  module Cyclic
    # Requiring basics intervals and note classes
    require_relative 'cyclic/interval'
    require_relative 'cyclic/interval_io'
    require_relative 'cyclic/note'
    require_relative 'cyclic/note_io'

    # Requiring modules defining operation on intervals and notes in scales classes
    require_relative 'cyclic/has_intervals'
    require_relative 'cyclic/has_notes'

    # Require scales, modes and chords classes
    require_relative 'cyclic/scales'
    require_relative 'cyclic/chords'

    # Finally requiring the method missing extension to note
    require_relative 'cyclic/note_extension'

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

    # Scales Constants
    MAJOR_SCALE = GenericScale.new('major', [0, 2, 4, 5, 7, 9, 11], %w(ionian dorian phrygian lydian mixolydian eolian locrian))
    PENTATONIC_SCALE = GenericScale.new('pentatonic', [0, 2, 4, 7, 9], ['major','','','','minor'])
    #DIMINISHED_SCALE = GenericScale.new('diminished', [0, 2, 3, 5, 6, 8, 9, 11], [''] * 8)

    SCALES = {
        major_scale: MAJOR_SCALE,
        pentatonic: PENTATONIC_SCALE,
    }

    MODES = {
        # Major scales
        ionian: MAJOR_SCALE.modes[0],
        dorian: MAJOR_SCALE.modes[1],
        phrygian: MAJOR_SCALE.modes[2],
        lydian: MAJOR_SCALE.modes[3],
        mixolydian: MAJOR_SCALE.modes[4],
        eolian: MAJOR_SCALE.modes[5],
        locrian: MAJOR_SCALE.modes[6],
        # Pentatonic scales
        major_pentatonic: PENTATONIC_SCALE.modes[0],
        minor_pentatonic: PENTATONIC_SCALE.modes[4],
    }

    # Chords Constants
    MAJOR_CHORD = GenericChord.new('major chord', 'M', [0, 4, 7])
    MINOR_CHORD = GenericChord.new('major chord', 'm', [0, 3, 7])
    DIMINISHED_CHORD = GenericChord.new('diminished chord', 'dim', [0, 4, 7])
    AUGMENTED_CHORD = GenericChord.new('augmented chord', 'aug', [0, 4, 7])

    SEVENTH_CHORD = GenericChord.new('7th chord', '7', MODES[:mixolydian])
    MAJOR_7_CHORD = GenericChord.new('major 7th chord', 'M7', [0, 4, 7, 11])
    MINOR_7_CHORD = GenericChord.new('major 7th chord', 'm7', [0, 3, 7, 10])
    HALF_DIMINISHED_CHORD = GenericChord.new('half diminished chord', 'ø', [0, 4, 7])
    #DIMINISHED_7_CHORD = GenericChord.new('diminished 7th chord', 'dim7', [0, 4, 7])

    TRIADS = {
        major_chord: MAJOR_CHORD,
        minor_chord: MINOR_CHORD,
        diminished_chord: DIMINISHED_CHORD,
        augmented_chord: AUGMENTED_CHORD,
    }

    SEVENTH_CHORDS = {
        seventh: SEVENTH_CHORD,
        major_7th: MAJOR_7_CHORD,
        minor_7th: MINOR_7_CHORD,
        half_diminished_chord: HALF_DIMINISHED_CHORD,
        #diminished_7th: DIMINISHED_7_CHORD,
    }

    CHORDS = TRIADS + SEVENTH_CHORDS

  end

end

