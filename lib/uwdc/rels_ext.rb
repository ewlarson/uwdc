module UWDC
  class RelsExt < Mets
    def nodes
      @get.xpath("//amdSec[contains(@ID,'#{@id}')]//RDF[1]")
    end
  end
end