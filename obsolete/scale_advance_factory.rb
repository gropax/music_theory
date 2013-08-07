require_relative 'note'
require_relative 'interval'
require_relative 'mode'

module Music

  module Cyclic

    # Some ideas:
    #   - Use modules inclusion/extensions instead of inheritance
    #   - Use self-extend modules for some scale and mode (intervals)

    module ScaleFactory

      def self.new(name, intervals, mode_names)
        class_name = classify_name(name)
        # Create a new subclass of Scale
        klass = Cyclic.module_eval "#{class_name} = Class.new(Scale)"

        klass.class_eval do
          # Initialize new scale's interval variable
          self.intervals = intervals.map { |int| Interval.new(int.to_i) }
          self.mode_names = mode_names

          # Creating modes
          self.intervals.each_index do |i|
            # Creating the mode class
            mode_name = ScaleFactory.classify_name(mode_names[i])
            mode_klass = Cyclic.module_eval "#{mode_name}Mode = Class.new(Mode)"

            # Add the mode to the Scale modes variable
            self.add_mode(mode_klass)

            # Open the mode's class to initialize it (scale, name, degree)
            mode_klass.class_eval do
              self.scale = klass
              self.degree = i + 1
            end
          end
        end
        klass
      end

      def self.scale(symbol)
        Cyclic.module_eval "#{classify_name(symbol)}"
      rescue
        nil
      end

      def self.classify_name(name)
        name.to_s.split(/\s|_/).map { |w| w.capitalize }.join
      end

    end


    module HasIntervals

      def intervals
        @intervals
      end

      def has?(symbol)
        if INTERVAL_NAMES.has_key? symbol
          intervals.include? INTERVAL_NAMES[symbol]
        else
          raise IntervalError, "Unknown interval: #{symbol}"
        end
      end

      def each_interval
        intervals.each { |i| yield i }
      end

    end


    class Scale
      extend HasIntervals
      include HasIntervals

      def self.mode_names=(mode_names)
        @mode_names = mode_names
      end

      def self.intervals=(intervals)
        @intervals = intervals
      end

      def self.modes
        @modes
      end

      def self.add_mode(mode)
        (@modes ||= []) << mode
      end

      def initialize(key)
        @key = key
        @notes = self.class.intervals.map { |int| key + int }
      end
      attr_reader :notes

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



  end

end