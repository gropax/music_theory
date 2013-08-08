require_relative 'note'
require_relative 'interval'

# TODO
#   - OK! scale and mode equality (scale == scale, mode == mode, scale == mode ?)
#   - OK! Dry the code and factorize with module inclusion
#   - Add functionality:
#       - OK! internal iterators on notes and intervals
#       - to_s and/or inspect
#       - OK! include_note?, include_interval?

module Music

  module Cyclic

    module HasIntervals

      def ==(other)
        @intervals == other.intervals
      end

      def same_intervals?(other)
        self.intervals == other.intervals
      end

      def from_same_scale?(other)
        if self.respond_to? :modes
          modes = self.modes
        else
          modes = self.scale.modes
        end
        modes.each do |m|
          return true if m.same_intervals? other
        end
        false
      end

      def has_interval?(interval)
        self.intervals.include? interval
      end

      def [](int)
        self.intervals[int.to_i]
      end

      def each_interval
        self.intervals.each { |i| yield i }
      end

      def map_intervals
        self.intervals.map { |i| yield i }
      end

    end


    module HasNotes

      def ==(other)
        @root == other.root && same_notes?(other)
      end

      def same_notes?(other)
        self.notes.sort == other.notes.sort
      end

      def has_note?(interval)
        self.notes.include? interval
      end

      def [](int)
        self.notes[int.to_i]
      end

      def each_note
        self.notes.each { |i| yield i }
      end

      def map_notes
        self.notes.map { |i| yield i }
      end

    end


    # Class modeling a mode of a particular scale in a particular key.
    #
    #
    class Mode
      include HasIntervals, HasNotes
      attr_reader :notes, :scale, :generic_mode, :root

      def initialize(scale, generic_mode, root)
        @scale, @generic_mode, @root = scale, generic_mode, root

        # Create the notes array from the generic mode's intervals
        @notes = generic_mode.intervals.map { |int| root + int }
      end

      def intervals
        @generic_mode.intervals
      end

      def key
        @scale.root
      end

    end

    # Class modeling a scale in a particular key.
    #
    #
    class Scale
      include HasIntervals, HasNotes
      attr_reader :notes, :modes, :generic_scale, :root

      def initialize(generic_scale, root)
        @generic_scale, @root = generic_scale, root

        # Creat the notes array from the generic scale's intervals
        @notes = generic_scale.intervals.map { |int| root + int }

        # Initialize the modes from the generic scale modes
        generic_scale.modes.each_index do |i|
          (@modes ||= []) << Mode.new(self, generic_scale.modes[i], @notes[i])
        end

      end

      def intervals
        @generic_scale.intervals
      end

    end



    class GenericMode
      include HasIntervals
      attr_reader :scale, :degree, :intervals, :name

      def initialize(scale, degree, name)
        @name, @degree, @scale = name, degree, scale

        # Create the array of intervals from the scale intervals, by modifying them relatively
        # to the new root, and applying the appropriate rotation to begin with the root
        first_int = @scale.intervals[@degree - 1]
        @intervals = scale.intervals.map { |int| int - first_int }.rotate(@degree - 1)
      end

      # This method is used to create an instance of the associated Mode in the given key. It first
      # calculate the corresponding scale key, then create a new Scale and return the corresponding
      # Mode.
      #
      #
      def of(note)
        # Get the key corresponding to the given mode root
        key = Note.new(note.to_i) - @scale.intervals[@degree - 1]
        # Create the scale and return the corresponding mode
        Scale.new(@scale, key).modes[@degree - 1]
      end

    end



    class GenericScale
      include HasIntervals
      attr_reader :modes, :intervals, :name

      def initialize(name, intervals, mode_names)
        @name = name

        # Initialize the array of intervals from the given ones
        @intervals = intervals.map { |i| Interval.new(i.to_i) }.uniq

        # For each of them, initialize the corresponding Mode
        @intervals.each_index do |i|
          (@modes ||= []) << GenericMode.new(self, i + 1, mode_names[i])
        end
      end

      # This method return an instance of the associated Scale in the given key
      #
      #
      def of(note)
        Scale.new( self, Note.new(note.to_i) )
      end

    end



  end

end