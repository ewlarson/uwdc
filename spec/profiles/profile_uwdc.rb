require 'ruby-prof'
require 'uwdc'

result = RubyProf.profile do
  kolors = UWDC::Mets.new('WFFLUJZK453Z687')
  kolors.mods
end

printer = RubyProf::GraphPrinter.new(result)

File.open('spec/profiles/uwdc_profile.txt', 'w+') do |file|
  printer.print(file)
end
