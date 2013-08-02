require 'test/unit'
require '../note'

module Music

  class CyclicNoteTest < Test::Unit::TestCase

    def test_init_with_integer
      assert_equal 'E', Music::CyclicNote.new(4).to_s
    end

    def test_init_with_big_integer
      assert_equal 'E', Music::CyclicNote.new(16).to_s
    end

    def test_init_with_string
      assert_equal 5, Music::CyclicNote.new('F').code
    end

    def test_init_with_string_with_flat
      assert_equal 6, Music::CyclicNote.new('F#').code
    end

    def test_init_with_wrong_string
      assert_raise Music::CyclicNote::NoteStringError do
        Music::CyclicNote.new('hello')
      end
    end

    def test_init_with_wrong_type
      assert_raise TypeError do
        Music::CyclicNote.new([])
      end
    end

    def test_relative_notes_getters
      d = Music::CyclicNote.new('C')
      assert_equal Music::CyclicNote.new(1).code, d.minor_second.code
      assert_equal Music::CyclicNote.new(2).code, d.major_second.code
      assert_equal Music::CyclicNote.new(3).code, d.minor_third.code
      assert_equal Music::CyclicNote.new(4).code, d.major_third.code
      assert_equal Music::CyclicNote.new(5).code, d.perfect_fourth.code
      assert_equal Music::CyclicNote.new(6).code, d.augmented_fourth.code
      assert_equal Music::CyclicNote.new(6).code, d.diminished_fifth.code
      assert_equal Music::CyclicNote.new(7).code, d.perfect_fifth.code
      assert_equal Music::CyclicNote.new(8).code, d.minor_sixth.code
      assert_equal Music::CyclicNote.new(9).code, d.major_sixth.code
      assert_equal Music::CyclicNote.new(10).code, d.minor_seventh.code
      assert_equal Music::CyclicNote.new(11).code, d.major_seventh.code
    end

    def test_unknown_method
      assert_raise NoMethodError do
        Music::CyclicNote.new(0).hello
      end
    end

    def test_flat_print_type
      printer = Music::CyclicNotePrinter.new.flat
      assert_equal 'Db', Music::CyclicNote.new(1).to_s(printer)
    end

    def test_constants
      assert_equal E, A.perfect_fifth
      assert_equal F, C.perfect_fourth
      assert_equal A, C.major_sixth
    end

  end

end
