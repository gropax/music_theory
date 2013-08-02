require 'test/unit'
require '../scale'

module Music::Cyclic

  class AbstractScaleTest < Test::Unit::TestCase

    def test_init_with_major_scale
      scale = AbstractScale('Major Scale', [])
    end

  end

end
