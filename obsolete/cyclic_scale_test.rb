require 'test/unit'
require '../music_theory'


class CyclicScaleTest < Test::Unit::TestCase
  include Music::Cyclic

  def setup
    @major_scale = ScaleFactory.new('major scale', [0, 2, 4, 5, 7, 9, 11], %w(ionian dorian phrygian lydian mixolydian eolian locrian))
    @c_major_scale = @major_scale.new(C)
  end

  def test_class_has_intervals
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Interval.new(i) }, @major_scale.intervals
  end

  def test_class_look_for_interval
    assert @major_scale.has? :major_third
    refute @major_scale.has? :minor_third
  end

  def test_instance_has_notes
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Note.new(i) }, @c_major_scale.notes
  end

  def test_instance_look_for_note
    assert @c_major_scale.include? E
    refute @c_major_scale.include? Eb
  end

  def test_instance_has_intervals_too
    assert_equal [0, 2, 4, 5, 7, 9, 11].map { |i| Interval.new(i) }, @c_major_scale.intervals
  end

  def test_instance_look_for_interval
    assert @c_major_scale.has? :major_third
    refute @c_major_scale.has? :minor_third
  end



end

