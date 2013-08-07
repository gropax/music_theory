require_relative 'note'
require_relative 'interval'

module Music

  module Cyclic

    class Mode
      attr_reader :notes, :scale, :generic_mode, :root

      def initialize(scale, generic_mode, root)
        @scale, @generic_mode, @root = scale, generic_mode, root
        @notes = generic_mode.intervals.map { |int| root + int }
      end

    end

    class Scale
      attr_reader :notes, :modes, :generic_scale, :root

      def initialize(generic_scale, root)
        @generic_scale, @root = generic_scale, root
        @notes = generic_scale.intervals.map { |int| root + int }
        generic_scale.modes.each_index do |i|
          (@modes ||= []) << Mode.new(self, generic_scale.modes[i], @notes[i])
        end
      end

      def ==(other)
        @notes == other.notes
      end

    end

    class GenericMode
      attr_reader :scale, :degree, :intervals, :name

      def initialize(scale, degree, name)
        @name, @degree, @scale = name, degree, scale
        first_int = @scale.intervals[@degree - 1]
        @intervals = scale.intervals.map { |int| int - first_int }.rotate(@degree - 1)
      end

      def in_key_of(note)
        # Get the key corresponding to the given mode root
        key = Note.new(note.to_i) - @scale.intervals[@degree - 1]
        # Create the scale and return the corresponding mode
        Scale.new(@scale, key).modes[@degree - 1]
      end

    end

    class GenericScale
      attr_reader :modes, :intervals, :name

      def initialize(name, intervals, mode_names)
        @name = name
        @intervals = intervals.map { |i| Interval.new(i.to_i) }
        @intervals.each_index do |i|
          (@modes ||= []) << GenericMode.new(self, i + 1, mode_names[i])
        end
      end

      def in_key_of(note)
        Scale.new( self, Note.new(note.to_i) )
      end

      def ==(other)
        @intervals == other.intervals
      end

    end



  end

end