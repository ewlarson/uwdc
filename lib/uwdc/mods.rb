module UWDC
  class Mods < Mets
    def nodes
      @get.xpath("//dmdSec[contains(@ID,'#{@id}')]//mods[1]")
    end
  
    def titles
      nodes.xpath("//mods/titleInfo//title").map{|n| n.text}
    end
  
    def dates
      nodes.xpath("//mods/originInfo//dateIssued").map{|n| n.text}
    end
  
    def forms
      nodes.xpath("//mods/physicalDescription//form").map{|n| n.text}
    end
  
    def abstracts
      nodes.xpath("//mods//abstract").map{|n| n.text}
    end
  
    def subjects
      nodes.xpath("//mods/subject//topic").map{|n| n.text}
    end
  
    def valid?
      response = http_client.get("http://www.loc.gov/standards/mods/mods.xsd")
      xsd = Nokogiri::XML::Schema.new(response.body)
      xml = Nokogiri::XML(nodes.to_xml)
      xsd.valid?(xml)
    end
  end
end