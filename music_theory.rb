
require_relative 'cyclic'
require_relative 'absolute/note'
require_relative 'absolute/note_io'

module Music

  LIBPATH = File.absolute_path(__FILE__)

end

include Music::Cyclic