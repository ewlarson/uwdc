module UWDC
  # Obtain UWDC METS metadata via an object identifier.
  class Mets
    attr_accessor :id, :xml
    
    # Intialize a UWDC Mets object
    #
    # @param [String] id of the object
    def initialize(id, xml=nil)
      @id = id
      @xml ||= UWDC::XML.new(@id,xml)
      raise(XmlNotFound) unless [nil,200].include?(@xml.status)
    end
    
    def nodes
      @xml.nodes
    end
    
    def to_json
      Hash.from_xml(nodes.to_xml).to_json
    end
    
    def to_ruby
      Hash.from_xml(nodes.to_xml)
    end
    
    def to_xml
      nodes.to_xml
    end
    
    def mods
      @mods = Mods.new(@id)
    end
    
    def struct_map(id=@id)
      @struct_map = StructMap.new(id)
    end
    
    def rels_ext(id=@id)
      @rels_ext = RelsExt.new(id)
    end
    
    def file_sec(id=@id)
      @file_sec = FileSec.new(id)
    end
    
    def dublin_core(id=@id)
      @dublin_core = DublinCore.new(id)
    end
    
    private
    
    def identifier(id)
      id[0,id.rindex(/[\.-]/)]
    end
    
    def clean_nodes(node_array)
      node_array.map{|node| node.text}.reject(&:empty?)
    end
    
    def pick_attribute(node_array, attribute)
      node_array.map{|node| node.attribute(attribute).value}.reject(&:empty?)
    end
  end
  
  # Return one division from the StructMap
  class Div
    attr_accessor :id, :admid, :order
    
    def initialize(node)
      @node     = node
      @id       = node["ID"]
      @admid    = node["ADMID"]
      @order    = node["ORDER"] ? node["ORDER"] : ""
    end
    
    def file_pointers
      @node.children.map{|node| node["FILEID"] if node.name == "fptr"}.compact
    end
    
    def kids
      @node.children.map{|div| Div.new(div) if div.name == "div"}.compact
    end
  end

  # Return one file asset from the FileSec
  class FileAsset
    attr_accessor :id, :mimetype, :use, :href, :title
    
    def initialize(node)
      @id   = node["ID"]
      @mimetype = node["MIMETYPE"]
      @use      = node["USE"]
      @href     = node.children.detect{|child| child.name == "FLocat"}.attr('href')
    end
  end
end