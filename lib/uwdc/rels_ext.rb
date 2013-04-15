module UWDC
  class RelsExt < Mets
    def nodes
      @get.xpath("//amdSec[contains(@ID,'#{@id}')]//RDF[1]")
    end
    
    def models
      nodes.xpath("//amdSec[contains(@ID,'RELS-EXT')]").inject({}) do |result, node|
        result["#{node.attribute('ID')}"] = pick_attribute(node.xpath(".//hasModel"), 'resource')
        result
      end
    end
  end
end