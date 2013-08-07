require_relative 'note'
require_relative 'interval'
require_relative 'scale'

require_relative 'constants'


module Music::Cyclic

  class Note

    def method_missing(m, *args, &block)
      if INTERVAL_NAMES.include? m
        get_relative(INTERVAL_NAMES[m])
      elsif ScaleFactory.scale m
        ScaleFactory.scale(m).new(self)
      else
        raise NoMethodError, "No method called #{m}"
      end
    end

  end

end