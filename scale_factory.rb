require_relative 'note'
require_relative 'interval'

module Music

  module Cyclic

    class Scale

      def self.new(name, intervals)
        class_name = classify_name(name)
        klass = Cyclic.module_eval "#{class_name} = Class.new(Scale)"
        p klass
        klass.class_eval do
          @@intervals = intervals.map { |int| Interval.new(int.to_i) }
        end
        klass
      end

      def self.classify_name(name)
        name.to_s.split(/\s|_/).map { |w| w.capitalize }.join
      end

      def initialize(key)
        @key = key
        @notes = @@intervals.map { |int| key + int }.sort { |note| note.to_i }
      end

      def has?(symbol)
        if INTERVAL_NAMES.has_key? symbol
          @intervals.include? INTERVAL_NAMES[symbol]
        else
          raise IntervalError, "Unknown interval: #{symbol}"
        end
      end

    end
  end

end