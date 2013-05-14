UWDC
====

[![Gem Version](https://badge.fury.io/rb/uwdc.png)](http://badge.fury.io/rb/uwdc)
[![Build Status](https://travis-ci.org/ewlarson/uwdc.png)](https://travis-ci.org/ewlarson/uwdc)
[![Dependency Status](https://gemnasium.com/ewlarson/uwdc.png)](https://gemnasium.com/ewlarson/uwdc)
[![Code Climate](https://codeclimate.com/github/ewlarson/uwdc.png)](https://codeclimate.com/github/ewlarson/uwdc)

## Synopsis

Gem for accessing University of Wisconsin Digital Collection items from our Fedora Commons repository.

## Install

gem install uwdc

## Usage

### METS
Obtain the METS metadata for a UWDC object.

```ruby
require 'uwdc'
mets = UWDC::Mets.new('33QOBSVPJLWEM8S')
mets.mods
mets.mods.titles
```

UWDC METS will contain:

* MODS
* Origin (PREMIS)
* RELS-EXT
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
      <th>UWDC::Mods method</th>
      <th>MODS Element</th>
      <th>Example output</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>mods.titles</td>
      <td>titleInfo</td>
      <td>["A life idyl", ...]</td>
    </tr>
    <tr>
      <td>mods.names</td>
      <td>name</td>
      <td>[OpenStruct.new(:name, :role), ...]</td>
    </tr>
    <tr>
      <td>mods.dates</td>
      <td>originInfo</td>
      <td>["1869"]</td>
    </tr>
    <tr>
      <td>mods.forms</td>
      <td>physicalDescription</td>
      <td>["text"]</td>
    </tr>
    <tr>
      <td>mods.abstracts</td>
      <td>abstract</td>
      <td>["Green leather with gold stamping...", ...]</td>
    </tr>
    <tr>
      <td>mods.subjects</td>
      <td>subject</td>
      <td>["Bookbinding--Techniques--Gold stamping", ...]</td>
    </tr>
    <tr>
      <td>mods.access_conditions</td>
      <td>accessCondition</td>
      <td>[OpenStruct.new(:rights, :reuse), ...]</td>
    </tr>
    <tr>
      <td>mods.related_items</td>
      <td>relatedItem</td>
      <td>[OpenStruct.new(:label, :name), ...]</td>
    </tr>
  </tbody>
</table>

Transform via to_* calls. Supports JSON, Ruby and XML

```ruby
mods.to_json
mods.to_ruby
mods.to_xml
```

## Changelog

Nothing to mention yet.

## Contributors

Eric Larson

## Copyright

UWDC © 2013 Board of Regents - University of Wisconsin System. UWDC is licensed under the MIT license. Please see the LICENSE for more information.