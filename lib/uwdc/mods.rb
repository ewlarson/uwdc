require 'ostruct'

module UWDC
  # Public: Obtain the MODS metadata for a UWDC METS object
  #
  # Example
  #
  # @mods = UWDC::Mods.new('ECJ6ZXEYWUE7B8W')
  # # => MODS object fetched from Fedora
  # 
  # @mods = UWDC::Mods.new('ECJ6ZXEYWUE7B8W', File.read('../file.xml'))
  # # => object constructed from XML file
  class Mods < Mets
    
    # Public: standardized, supported MODS attributes
    def self.attributes
      [:titles, :names, :dates, :forms, :abstracts, :subjects, :related_items]
    end

    # Public: Access the XML nodes of the MODS XML
    #
    # Example
    #
    # @mods.nodes
    # # => Nokogiri::XML::NodeSet
    #
    # Returns the Nokogiri::XML::NodeSet for the parsed MODS XML
    def nodes
      @xml.nodes.xpath("//dmdSec[contains(@ID,'#{@id}')]//mods[1]")
    end
    
    # Public: Access the XML nodes of the METS file
    #
    # Example
    #
    # @mods.metadata
    # # => {:title => ['A life idyl', ...], ...}
    #
    # Returns Hash
    def metadata
      attributes = UWDC::Mods.attributes.inject({}) do |result, method|
        result[method] = self.send(method)
        result
      end
      attributes[:access_conditions] = self.access_conditions
      attributes
    end
    
    # Public: Array of title data
    #
    # Example
    #
    # @mods.titles
    # # => ['A life ldyl', ...]
    # 
    # Returns Array
    def titles
      clean_nodes(nodes.xpath("//mods/titleInfo//title"))
    end
    
    # Public: Array of roles and nameParts
    #
    # Example
    #
    # @mods.names
    # # => [#<OpenStruct name="Foo", role="Bar">, ...]
    #
    # Returns Array of OpenStructs
    def names
      nodes.xpath("//mods/name").inject([]){|arr,node| arr << capture_name(node); arr}
    end
    
    # Public: Array of dates
    #
    # Example
    #
    # @mods.dates
    # # => ["1985", ...]
    #
    # Returns Array of Strings
    def dates
      clean_nodes(nodes.xpath("//mods/originInfo//dateIssued"))
    end
  
    # Public: Array of forms
    # Example
    #
    # @mods.forms
    # # => ["StillImage", ...]
    #
    # Returns Array of Strings
    def forms
      clean_nodes(nodes.xpath("//mods/physicalDescription//form"))
    end

    # Public: Array of abstracts (sometimes translated)
    # @TODO: support lang here
    #
    # Example
    #
    # @mods.abstracts
    # # => ["The man is an entertainer who captured the wild hyena...", ...]
    #
    # Returns Array of Strings
    def abstracts
      clean_nodes(nodes.xpath("//mods//abstract"))
    end
  
    # Public: Array of subject data
    #
    # Example
    #
    # @mods.subjects
    # # => ["Delehanty, James", "Animals", ...]
    #
    # Returns Array of Strings
    def subjects
      clean_nodes(nodes.xpath("//mods/subject//topic"))
    end
    
    # Public: Array of geographic subject data
    # @TODO: subjects_heirarchical_geographic
    #
    # Example
    # @mods.subjects_heirarchical_geographic
    # # => ["Foo", "Bar", "Baz"]
    def subjects_heirarchical_geographic
    end
    
    # Public: OpenStruct - Terms of Use and Reuse Rights
    #
    # Example
    # 
    # @mods.access_conditions
    # # => #<OpenStruct rights=["Delehanty, Jim"], reuse=["Delehanty, Jim"]>
    #
    # Retuns an OpenStruct
    def access_conditions
      OpenStruct.new(rights: rights, reuse: reuse)
    end
    
    # Public: Array of Structs - Related items' label and value
    #
    # Example
    #
    # @mods.related_items
    # # => [#<OpenStruct label="Part of", name="Africa Focus">, ...]
    #
    # Retuns Array of OpenStruct
    def related_items
      nodes.xpath("//mods/relatedItem").inject([]){|arr,node| arr << capture_relation(node) ; arr }
    end
  
    # Public: Check MODS for validity
    # @TODO: Use the UWDC MODS Schema
    #
    # Example
    #
    # @mods.valid?
    # # => true
    #
    # Returns Boolean
    def valid?
      response = http_client.get("http://www.loc.gov/standards/mods/mods.xsd")
      xsd = Nokogiri::XML::Schema.new(response.body)
      xml = Nokogiri::XML(nodes.to_xml)
      xsd.valid?(xml)
    end
    
    private

    # Internal: Rights/Ownership String    
    def rights
      clean_nodes(nodes.xpath("//accessCondition[@type='rightsOwnership']"))
    end

    # Internal: Reuse Rights String    
    def reuse
      clean_nodes(nodes.xpath("//accessCondition[@type='useAndReproduction']"))
    end
    
    # Internal: Related Label String
    def related_label(node)
      node['displayLabel'] ? node['displayLabel'] : "Related item"
    end
    
    # Internal: Capture relation metadata
    def capture_relation(node)
      OpenStruct.new(label: related_label(node), name: node.xpath('.//name | .//title').text)
    end

    # Internal: Capture name metadata
    def capture_name(node)
      OpenStruct.new(name: node.xpath('.//namePart').text, role: node.xpath('.//role/roleTerm').text)
    end
  end
end