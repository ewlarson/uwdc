require 'uwdc/version'
require 'httpclient/include_client'
require 'httpclient'
require 'nokogiri'
require 'json'
require 'active_support/core_ext/hash'

# UWDC
module UWDC
  XmlNotFound = Class.new(StandardError)
end

require 'uwdc/mets'
require 'uwdc/mods'
require 'uwdc/origin'
require 'uwdc/rels_ext'
require 'uwdc/file_sec'
require 'uwdc/struct_map'
require 'uwdc/display'
require 'uwdc/dublin_core'
require 'uwdc/xml'