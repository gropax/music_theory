require 'test/unit'
require "C:/Users/Maxime/RubymineProjects/guitar/music_theory"

class CyclicGenericScaleAndModeTest < Test::Unit::TestCase

  include Music::Cyclic

  def setup
    @major_scale = GenericScale.new('major', [0, 2, 4, 5, 7, 9, 11],
        %w(ionian dorian phrygian lydian mixolydian eolian locrian))
    @ionian_mode = @major_scale.modes[0]
  end

  def test_generic_scale_has_intervals
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Interval.new(i) }, @major_scale.intervals
  end

  def test_generic_scale_has_name
    assert_equal 'major', @major_scale.name
  end

  def test_generic_scale_has_generic_modes
    assert_equal 7, @major_scale.modes.size
    assert_equal GenericMode, @major_scale.modes[3].class
  end


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




end