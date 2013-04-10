module UWDC
  class Origin < Mets
    def nodes
      @get.xpath("//amdSec[contains(@ID,'#{@id}')]//origin[1]")
    end
  end
end