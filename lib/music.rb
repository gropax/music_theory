
require_relative 'music/cyclic'
require_relative 'music/absolute/note'
require_relative 'music/absolute/note_io'

module Music

  LIBPATH = File.absolute_path(__FILE__)

end

include Music::Cyclic