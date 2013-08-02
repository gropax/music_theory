require 'test/unit'

class AbsoluteNoteTest < Test::Unit::TestCase

  def test_init_with_integer
    assert_equal AbsoluteNote.new(60).to_s, 'C3'
  end

  def test_init_with_integer_to_big
    assert_raise NoteRangeError do
      AbsoluteNote.new(140)
    end
  end

  def test_init_with_negative_integer
    assert_raise NoteRangeError do
      AbsoluteNote.new(-10)
    end
  end

  def test_init_with_string
    assert_equal AbsoluteNote.new('C2').midi, 48
  end

  def test_init_with_string_to_big
    assert_raise NoteRangeError do
      AbsoluteNote.new('C10')
    end
  end

  def test_init_with_string_to_small
    assert_raise NoteRangeError do
      AbsoluteNote.new('G-2')
    end
  end

  def test_init_with_wrong_string
    assert_raise NoteRangeError do
      AbsoluteNote.new('hello')
    end
  end

  def test_sharp
    assert_equal AbsoluteNote.new(61).to_s, 'C#3'
    assert_equal AbsoluteNote.new(61).to_s(:sharp), 'C#3'
  end

  def test_flat
    assert_equal AbsoluteNote.new(61).to_s(:flat), 'Db3'
  end

  def test_get_cyclic_note
    an = AbsoluteNote.new(62)
    assert_equal an.cyclic, CyclicNote.new(2)
  end

end