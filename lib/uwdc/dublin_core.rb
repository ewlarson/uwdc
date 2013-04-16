module UWDC
  class DublinCore < Mets
    def nodes
      @xml.nodes.xpath("//dmdSec//dc")
    end
    
    def titles
      nodes.inject({}) do |result, children|
        result[capture_id(children)] = capture_title(children)
        result
      end
    end
    
    private
    
    def capture_id(children)
      fix_id(clean_nodes(children.xpath(".//identifier[1]"))[0])
    end
    
    def capture_title(children)
      clean_nodes(children.xpath(".//title[1]"))[0]
    end
    
    def fix_id(id)
      "x#{id.gsub('.','-').gsub(':','_')}"
    end
  end
end