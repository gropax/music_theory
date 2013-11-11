require_relative 'scale_advance_factory'

module Music

  module Cyclic

    class Mode
      extend HasIntervals
      include HasIntervals

      def self.scale
        @scale
      end

      def self.scale=(scale)
        @scale = scale
      end

      def self.degree
        @degree
      end

      def self.degree=(degree)
        @degree = degree
      end

      def self.intervals
        first_int = @scale.intervals[@degree - 1]
        @scale.intervals.map { |int| int - first_int }.rotate(@degree - 1)
      end

      def self.name
        @scale.mode_names[@degree - 1]
      end

      def initialize(root)
        @root = root
        @notes = self.class.intervals.map { |int| root + int }
      end

      def intervals
        self.class.intervals
      end

      def include?(note)
        @notes.include?(note)
      end

      def each
        @notes.each { |n| yield n }
      end

    end


    #ScaleFactory.new('major scales', [0, 2, 4, 5, 7, 9, 11], %w(ionian dorian phrygian lydian mixolydian eolian locrian))
    #p 'intervals'
    #MajorScale.new(A).each_interval { |i| p i }
    #p ''
    #p 'notes'
    #MajorScale.new(A).each { |n| p n }
    #
    #p 'intervals'
    #C.major_scale.each_interval { |i| p i }
    #p ''
    #p 'notes'
    #C.major_scale.each { |n| p n }
    #
    #p 'modes:'
    #p "size = #{MajorScale.modes.size}"
    #MajorScale.modes.each { |m| p m }
    #
    #p 'F Lydian'
    #LydianMode.intervals.each { |i| p i }
    #F.lydian_mode.each { |n| p n }

  end

end