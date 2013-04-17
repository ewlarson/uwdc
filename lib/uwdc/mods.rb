require 'ostruct'

module UWDC
  # Return MODS metadata for UWDC METS object
  class Mods < Mets
    
    def self.attributes
      [:titles, :names, :dates, :forms, :abstracts, :subjects, :related_items]
    end

    def nodes
      @xml.nodes.xpath("//dmdSec[contains(@ID,'#{@id}')]//mods[1]")
    end
    
    def metadata
      attributes = UWDC::Mods.attributes.inject({}) do |result, method|
        result[method] = self.send(method)
        result
      end
      attributes[:access_conditions] = self.access_conditions
      attributes
    end
    
    # Array of title data
    def titles
      clean_nodes(nodes.xpath("//mods/titleInfo//title"))
    end
    
    # Array of roles and nameParts
    def names
      nodes.xpath("//mods/name").inject([]){|arr,node| arr << capture_name(node); arr}
    end
  
    # Array of dates
    def dates
      clean_nodes(nodes.xpath("//mods/originInfo//dateIssued"))
    end
  
    # Array of forms
    def forms
      clean_nodes(nodes.xpath("//mods/physicalDescription//form"))
    end

    # Array of abstracts (sometimes translated)
    # @TODO: support lang here  
    def abstracts
      clean_nodes(nodes.xpath("//mods//abstract"))
    end
  
    # Array of subject data
    def subjects
      clean_nodes(nodes.xpath("//mods/subject//topic"))
    end
    
    # @TODO: subjects_heirarchical_geographic
    def subjects_heirarchical_geographic
    end
    
    # Struct - Terms of Use and Ri
    def access_conditions
      OpenStruct.new(rights: rights, reuse: reuse)
    end
    
    # Array of Structs - Related items' label and value
    def related_items
      nodes.xpath("//mods/relatedItem").inject([]){|arr,node| arr << capture_relation(node) ; arr }
    end
  
    # Check MODS for validity
    # @TODO: UWDC MODS Schema?
    def valid?
      response = http_client.get("http://www.loc.gov/standards/mods/mods.xsd")
      xsd = Nokogiri::XML::Schema.new(response.body)
      xml = Nokogiri::XML(nodes.to_xml)
      xsd.valid?(xml)
    end
    
    private
    
    def rights
      clean_nodes(nodes.xpath("//accessCondition[@type='rightsOwnership']"))
    end
    
    def reuse
      clean_nodes(nodes.xpath("//accessCondition[@type='useAndReproduction']"))
    end
    
    def related_label(node)
      node['displayLabel'] ? node['displayLabel'] : "Related item"
    end
    
    def capture_relation(node)
      OpenStruct.new(label: related_label(node), name: node.xpath('.//name | .//title').text)
    end
    
    def capture_name(node)
      OpenStruct.new(name: node.xpath('.//namePart').text, role: node.xpath('.//role/roleTerm').text)
    end
  end
end