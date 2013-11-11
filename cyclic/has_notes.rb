module Music
  module Cyclic
    # Mixin for objects than contains cyclic notes
    #
    # @note
    #   Need the #root and #notes method to be defined by the base module
    #
    # @example
    #   # Define operations on notes
    #   A.minor_scale.same_notes?(C.major_scale) #=> true
    #   A.minor_scale.has_note?(C) #=> true
    #   A.minor_scale[4] #=> <Cyclic::Note C >
    #   # Two objects are equal if they have same root and notes
    #   A.minor_scale == C.major_scale #=> false
    # 
    module HasNotes
      def root
        raise NotImplementedError, '#root method not implemented'
      end

      def notes
        raise NotImplementedError, '#notes method not implemented'
      end

      def ==(other)
        root == other.root && same_notes?(other)
      end

      def same_notes?(other)
        self.notes.sort == other.notes.sort
      end

      def has_note?(note)
        self.notes.include? note
      end

      def [](int)
        self.notes[int.to_i]
      end
    end
  end
end
