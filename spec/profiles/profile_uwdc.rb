require 'ruby-prof'
require 'uwdc'

result = RubyProf.profile do
  kolors = UWDC::Mets.new('WFFLUJZK453Z687')
  kolors.mods
end

printer = RubyProf::MultiPrinter.new(result)
printer.print(:path => "spec/profiles", :profile => "uwdc")
