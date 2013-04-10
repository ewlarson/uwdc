module UWDC
  class Mods < Mets
    def nodes
      @get.xpath("//dmdSec[contains(@ID,'#{@id}')]//mods[1]")
    end
  
    def titles
      clean_nodes(nodes.xpath("//mods/titleInfo//title"))
    end
    
    def names
      contributor = Struct.new(:name, :role)
      nodes.xpath("//mods/name").inject([]){|arr,name| arr << contributor.new(name_part(name), role(name)); arr}
    end
  
    #@TODO: simple dates
    def dates
      clean_nodes(nodes.xpath("//mods/originInfo//dateIssued"))
    end
  
    def forms
      clean_nodes(nodes.xpath("//mods/physicalDescription//form"))
    end
  
    def abstracts
      clean_nodes(nodes.xpath("//mods//abstract"))
    end
  
    def subjects
      clean_nodes(nodes.xpath("//mods/subject//topic"))
    end
    
    # @TODO: subjects_heirarchical_geographic
    def subjects_heirarchical_geographic
    end
    
    def access_conditions
      conditions = Struct.new(:rights, :reuse)
      conditions.new(rights,reuse)
    end
    
    # @TODO: Related Items
    def related_items
    end
  
    def valid?
      response = http_client.get("http://www.loc.gov/standards/mods/mods.xsd")
      xsd = Nokogiri::XML::Schema.new(response.body)
      xml = Nokogiri::XML(nodes.to_xml)
      xsd.valid?(xml)
    end
    
    private
    
    def name_part(name)
      name_part = name.xpath('//namePart').text
    end
    
    def role(name)
      name.xpath('//role/roleTerm').text
    end
    
    def rights
      clean_nodes(nodes.xpath("//accessCondition[@type='rightsOwnership']"))
    end
    
    def reuse
      clean_nodes(nodes.xpath("//accessCondition[@type='useAndReproduction']"))
    end
  end
end