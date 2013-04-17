module UWDC
  # Return the UWDC/PREMIS-ish submitters of a METS file
  class Origin < Mets
    def nodes
      @xml.nodes.xpath("//amdSec[contains(@ID,'#{@id}')]//origin[1]")
    end

    def submitters
      clean_nodes(nodes.xpath(".//agentName"))
    end
  end
end