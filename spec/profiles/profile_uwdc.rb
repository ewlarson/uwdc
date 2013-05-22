require 'ruby-prof'
require 'uwdc'

result = RubyProf.profile do
  kolors = UWDC::Mets.new('WFFLUJZK453Z687')
  kolors.mods
  kolors.display.images
  kolors.display.audio
end

printer = RubyProf::MultiPrinter.new(result)
printer.print(:path => "spec/profiles", :profile => "uwdc")
