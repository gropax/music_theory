module Music
  module Cyclic
    class Note
      # Add dynamic methods to easily create notes, scales and mode from a note.
      #
      # @example
      #   # Create a new note from an interval
      #   A.minor_third => 'F#'
      #   # Create a scale from a generic scale name
      #   C.major_scale
      #   # Create a mode from a generic mode name
      #   G.mixolydian_mode
      #
      # @todo Add a #respond_to_missing? method
      #
      def method_missing(method, *args, &block)
        if INTERVAL_NAMES.include? method
          get_relative(INTERVAL_NAMES[method])
        elsif SCALES.include? method
          SCALES[method].of(self)
        elsif MODES.include? method
          MODES[method].of(self)
        else
          super
        end
      end
    end
  end
end