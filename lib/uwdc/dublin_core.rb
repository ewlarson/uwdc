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
    
    # @FIXME: UWDC identifiers are all jacked up
    # - mets[@OBJID] => 1711.dl:FJIOAPU6Z7UKR8E
    # - dmdSec[@ID] => x1711-dl_FJIOAPU6Z7UKR8E
    # - mods/identifier[@type='handle'] => 1711.dl/FJIOAPU6Z7UKR8E
    # - mods/recordInfo/recordIdentifier => 1711.dl:FJIOAPU6Z7UKR8E.BIB0ˇ
    def fix_id(id)
      "x#{id.gsub('.','-').gsub(':','_')}"
    end
  end
end