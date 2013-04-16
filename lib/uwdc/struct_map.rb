module UWDC
  class StructMap < Mets
    def nodes
      @xml.nodes.xpath("//structMap[contains(@ID,'#{@id}')]")
    end
  
    def structure
      nodes.xpath('div').inject([]){|result, div| result << Div.new(div)}
    end
  end
end