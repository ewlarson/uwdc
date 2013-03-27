uwdc
====

Rubygem for getting University of Wisconsin Digital Collection objects from Fedora.

* METS
* MODS
* ORIGIN (Premis)
* RELS-EXT

## Usage

```ruby
require 'uwdc'

# Request METS via an id
mets = UWDC::Mets.new('33QOBSVPJLWEM8S')

# Request MODS via an id
mods = UWDC::Mods.new('33QOBSVPJLWEM8S')

# Transform via to_* calls
# - supports JSON, Ruby and XML
mods.to_json

mods.to_ruby
 => {"mods"=>{"titleInfo"=>{"title"=>"A life idyl"}, "identifier"=>"1711.dl/33QOBSVPJLWEM8S", "subject"=>[{"topic"=>"Bookbinding--Techniques--Gold stamping"}, {"topic"=>"Bookbinding--Edge treatment--All gilt"}, {"topic"=>"Books--Binding style--Raised bands--Simulated"}, {"topic"=>"Artistic style/Movement--Rococo Revival"}, {"topic"=>"Endpapers--Coated"}, {"topic"=>"Endpapers--Color--Yellow"}, {"topic"=>"Decoration/Ornament--Bordres--Ruled"}, {"topic"=>"Decoration/Ornament--Borders--Lines--Plain"}, {"topic"=>"Decoration/Ornament--Floral"}, {"topic"=>"Decoration/Ornament--Quatrefoils"}, {"topic"=>"Decoration/Ornament--Lines"}, {"topic"=>"Decoration/Ornament--Lines--Curled"}, {"topic"=>"Decoration/Ornament--Borders--Scrolls"}], "abstract"=>" Green leather with gold stampig on spine and sides. Yellow coated endpapers. All gilt. Simulated raised bands. Gold stamping on board edges and turn-ins.", "originInfo"=>{"dateIssued"=>"1869"}, "typeOfResource"=>nil, "physicalDescription"=>{"form"=>"text"}, "relatedItem"=>[{"displayLabel"=>"Part of", "type"=>"host", "titleInfo"=>{"title"=>"Publishers' Bindings Online, 1815-1930: The Art of Books"}}, {"displayLabel"=>"Collection", "type"=>"host", "identifier"=>"1711.dl:CollectionPBO", "name"=>"Publishers' Bindings Online, 1815-1930: The Art of Books"}], "accessCondition"=>["Collection may be protected under Title 17 of the U.S. Copyright Law.", "Collection may be protected under Title 17 of the U.S. Copyright Law."], "recordInfo"=>{"recordIdentifier"=>"1711.dl:33QOBSVPJLWEM8S.BIB0", "recordOrigin"=>"UWDCC", "recordChangeDate"=>"2007-07-19", "languageOfCataloging"=>{"languageTerm"=>"eng"}}}}

mods.to_xml