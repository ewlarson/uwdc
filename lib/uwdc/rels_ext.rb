module UWDC
  # Return the CMODELS related to METS file objects
  class RelsExt < Mets
    def nodes
      @xml.nodes.xpath("//amdSec[contains(@ID,'#{@id}')]//RDF[1]")
    end
    
    def models
      nodes.xpath("//amdSec[contains(@ID,'RELS-EXT')]").inject({}) do |result, node|
        result["#{node.attribute('ID')}"] = pick_attribute(node.xpath(".//hasModel"), 'resource')
        result
      end
    end
  end
end