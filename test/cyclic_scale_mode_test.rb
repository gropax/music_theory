require 'test/unit'
require '../music_theory'


class CyclicScaleModeTest < Test::Unit::TestCase
  include Music::Cyclic

  def setup
    @major_scale = GenericScale.new('major', [0, 2, 4, 5, 7, 9, 11], %w(ionian dorian phrygian lydian mixolydian eolian locrian))
    @ionian_mode = @major_scale.modes[0]
    @c_major_scale = @major_scale.in_key_of(0)
    @d_dorian_mode = @c_major_scale.modes[1]
    @e_phrygian = @major_scale.modes[2].in_key_of(4)
  end

  # GenericScale
  #
  def test_generic_scale_has_intervals
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Interval.new(i) }, @major_scale.intervals
  end

  def test_generic_scale_has_name
    assert_equal 'major', @major_scale.name
  end

  def test_generic_scale_has_generic_modes
    assert @major_scale.modes
    assert_equal 7, @major_scale.modes.size
    assert_equal GenericMode, @major_scale.modes[3].class
  end

  # GenericMode
  #
  def test_generic_mode_has_intervals
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Interval.new(i) }, @ionian_mode.intervals
  end

  def test_generic_mode_has_generic_scale
    assert @ionian_mode.scale
    assert_equal GenericScale, @ionian_mode.scale.class
  end

  def test_generic_mode_has_name
    assert_equal 'ionian', @ionian_mode.name
  end

  # Scale
  #
  def test_scale_has_notes
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Note.new(i) }, @c_major_scale.notes
  end

  def test_scale_has_root_and_generic_scale
    assert_equal @major_scale, @c_major_scale.generic_scale
    assert_equal C, @c_major_scale.root
  end

  def test_scale_has_modes
    assert_equal 7, @c_major_scale.modes.size
    assert_equal Mode, @c_major_scale.modes[3].class
  end

  # Mode
  #
  def test_mode_has_notes
    assert_equal [2, 4, 5, 7, 9, 11, 0].map { |i| Note.new(i) }, @d_dorian_mode.notes
  end

  def test_mode_has_scale_root_and_generic_mode
    assert_equal @c_major_scale, @d_dorian_mode.scale
    assert_equal D, @d_dorian_mode.root
    assert_equal @major_scale.modes[1], @d_dorian_mode.generic_mode
  end

  def test_create_mode_from_generic_mode
    assert_equal Mode, @e_phrygian.class
    assert_equal E, @e_phrygian.root
    assert_equal @major_scale.in_key_of(C), @e_phrygian.scale
  end





  #def test_class_look_for_interval
  #  assert @major_scale.has? :major_third
  #  refute @major_scale.has? :minor_third
  #end
  #
  #def test_instance_has_notes
  #  assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Note.new(i) }, @c_major_scale.notes
  #end
  #
  #def test_instance_look_for_note
  #  assert @c_major_scale.include? E
  #  refute @c_major_scale.include? Eb
  #end
  #
  #def test_instance_has_intervals_too
  #  assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Interval.new(i) }, @c_major_scale.intervals
  #end
  #
  #def test_instance_look_for_interval
  #  assert @c_major_scale.has? :major_third
  #  refute @c_major_scale.has? :minor_third
  #end




end
