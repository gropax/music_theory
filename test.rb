module Test
  extend self

  def self.bandu
    p "bandu"
  end

  def cadeau
    p "cadeau"
  end

end

Test.bandu
Test.cadeau

class Klass
  extend Test
end

Klass.cadeau
Klass.bandu