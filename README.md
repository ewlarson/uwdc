UWDC
====

[![Code Climate](https://codeclimate.com/github/ewlarson/uwdc.png)](https://codeclimate.com/github/ewlarson/uwdc)

## Synopsis

Gem for accessing University of Wisconsin Digital Collection items from our Fedora Commons repository.

## Usage

### METS
Obtain the METS metadata for a UWDC object.

```ruby
require 'uwdc'
mets = UWDC::Mets.new('33QOBSVPJLWEM8S') # Ignoring 
mets.mods
mets.mods.titles
```

UWDC METS will contain:

* MODS
* FileSec
* StructMap

### MODS
Obtain the MODS metadata for a UWDC object.

```ruby
mods = UWDC::Mods.new('33QOBSVPJLWEM8S')
mods.titles
```
MODS top-level elements are boiled in Ruby to something more dot-syntax friendly.

<table>
  <thead>
    <tr>
      <th>MODS Element</th>
      <th>UWDC::Mods method</th>
      <th>Example output</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>titleInfo</td>
      <td>mods.titles</td>
      <td>["A life idyl", ...]</td>
    </tr>
    <tr>
      <td>name</td>
      <td>mods.names</td>
      <td>[Struct.new(:name, :role), ...]</td>
    </tr>
    <tr>
      <td>originInfo</td>
      <td>mods.dates</td>
      <td>["1869"]</td>
    </tr>
    <tr>
      <td>physicalDescription</td>
      <td>mods.forms</td>
      <td>["text"]</td>
    </tr>
    <tr>
      <td>abstract</td>
      <td>mods.abstracts</td>
      <td>["Green leather with gold stamping...", ...]</td>
    </tr>
    <tr>
      <td>subject</td>
      <td>mods.subjects</td>
      <td>["Bookbinding--Techniques--Gold stamping", ...]</td>
    </tr>
    <tr>
      <td>accessCondition</td>
      <td>mods.access_conditions</td>
      <td>[Struct.new(:rights, :reuse), ...]</td>
    </tr>
    <tr>
      <td>relatedItem</td>
      <td>mods.related_items</td>
      <td>[Struct.new(:label, :name), ...]</td>
    </tr>
  </tbody>
</table>

```ruby
# Transform via to_* calls
# - supports JSON, Ruby and XML
mods.to_json

mods.to_ruby
 => {"mods"=>{"titleInfo"=>{"title"=>"A life idyl"}, "identifier"=>"1711.dl/33QOBSVPJLWEM8S", "subject"=>[{"topic"=>"Bookbinding--Techniques--Gold stamping"}, {"topic"=>"Bookbinding--Edge treatment--All gilt"}, {"topic"=>"Books--Binding style--Raised bands--Simulated"}, {"topic"=>"Artistic style/Movement--Rococo Revival"}, {"topic"=>"Endpapers--Coated"}, {"topic"=>"Endpapers--Color--Yellow"}, {"topic"=>"Decoration/Ornament--Bordres--Ruled"}, {"topic"=>"Decoration/Ornament--Borders--Lines--Plain"}, {"topic"=>"Decoration/Ornament--Floral"}, {"topic"=>"Decoration/Ornament--Quatrefoils"}, {"topic"=>"Decoration/Ornament--Lines"}, {"topic"=>"Decoration/Ornament--Lines--Curled"}, {"topic"=>"Decoration/Ornament--Borders--Scrolls"}], "abstract"=>" Green leather with gold stampig on spine and sides. Yellow coated endpapers. All gilt. Simulated raised bands. Gold stamping on board edges and turn-ins.", "originInfo"=>{"dateIssued"=>"1869"}, "typeOfResource"=>nil, "physicalDescription"=>{"form"=>"text"}, "relatedItem"=>[{"displayLabel"=>"Part of", "type"=>"host", "titleInfo"=>{"title"=>"Publishers' Bindings Online, 1815-1930: The Art of Books"}}, {"displayLabel"=>"Collection", "type"=>"host", "identifier"=>"1711.dl:CollectionPBO", "name"=>"Publishers' Bindings Online, 1815-1930: The Art of Books"}], "accessCondition"=>["Collection may be protected under Title 17 of the U.S. Copyright Law.", "Collection may be protected under Title 17 of the U.S. Copyright Law."], "recordInfo"=>{"recordIdentifier"=>"1711.dl:33QOBSVPJLWEM8S.BIB0", "recordOrigin"=>"UWDCC", "recordChangeDate"=>"2007-07-19", "languageOfCataloging"=>{"languageTerm"=>"eng"}}}}

mods.to_xml
```

## Changelog

Nothing to mention yet.

## Contributors

Eric Larson

## Copyright

UWDC © 2013 by Eric Larson. UWDC is licensed under the MIT license. Please see the LICENSE for more information.