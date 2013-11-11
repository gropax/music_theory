
module Music::Cyclic

  class ChordInterpreter

    def interpret(notes, root = nil)
      notes.map! { |n| Note.new(n.to_i) }
      if root
        root = Note.new(root.to_i)
        intervals = ([0] + notes.map { |n| root.interval_up_to(n) }).uniq
        process_intervals(intervals)
      else
        Note.all.map { |n| interpret(notes, n) }
      end
    end

    def process_intervals(intervals)
      if intervals.size == 2
        # Return an interval
      elsif intervals.size == 3
        # Special case for triads
        TRIADS.values.select { |t| t.intervals == intervals }
      elsif intervals.size >= 4

      end
      CHORDS.values.select { |c| c.intervals == intervals }

    end

  end

end