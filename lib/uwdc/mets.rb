module UWDC
  # Public: Methods to obtain UWDC METS metadata via an object identifier.
  #
  # Examples
  #
  # UWDC::Mets.new('ECJ6ZXEYWUE7B8W')
  # # => object fetched from Fedora
  # 
  # UWDC::Mets.new('ECJ6ZXEYWUE7B8W', File.read('../file.xml'))
  # # => object constructed from XML file
  class Mets
    attr_accessor :id, :xml
    
    # Public: Intialize a UWDC Mets object
    #
    # id  - A UWDC identifier.
    # xml - An optional XML file.
    #
    # Raises XmlNotFound if the xml file cannot be found or fetched.
    def initialize(id, xml=nil)
      @id = id
      @xml ||= UWDC::XML.new(@id,xml)
      raise(XmlNotFound) unless [nil,200].include?(@xml.status)
    end
    
    # Public: Access the XML nodes of the METS file
    #
    # Example
    #
    # @mets.nodes
    # # => Nokogiri::XML::NodeSet
    #
    # Returns the Nokogiri::XML::NodeSet for the parsed METS file
    def nodes
      @xml.nodes
    end
    
    # Public: Convert the XML nodes to JSON
    # 
    # Example
    #
    # @mets.to_json
    # # => {'mets': ...}
    #
    # Returns the Nokogiri::XML::NodeSet as JSON
    def to_json
      Hash.from_xml(nodes.to_xml).to_json
    end

    # Public: Convert the XML nodes to Ruby
    # 
    # Example
    #
    # @mets.to_ruby
    # # => {'mets': ...}
    #
    # Returns the Nokogiri::XML::NodeSet as a Ruby Hash
    def to_ruby
      Hash.from_xml(nodes.to_xml)
    end
    
    # Public: Convert the XML nodes to XML
    # 
    # Example
    #
    # @mets.to_xml
    # # => "<mets>..."
    #
    # Returns the Nokogiri::XML::NodeSet as XML
    def to_xml
      nodes.to_xml
    end
    
    # Public: Access the MODS descriptive metadata XML nodes
    # 
    # Example
    #
    # @mets.mods
    # # => UWDC::Mods
    #
    # Returns a UWDC::Mods object
    def mods
      @mods = Mods.new(@id)
    end
    
    # Public: Access the StructMap structural map section XML nodes
    # 
    # Example
    #
    # @mets.struct_map
    # # => UWDC::StructMap
    #
    # Returns a UWDC::StructMap object
    def struct_map(id=@id)
      @struct_map = StructMap.new(id)
    end

    # Public: Access the RelsExt RDF relation XML nodes
    # 
    # Example
    #
    # @mets.rels_ext
    # # => UWDC::RelsExt
    #
    # Returns a UWDC::RelsExt object
    def rels_ext(id=@id)
      @rels_ext = RelsExt.new(id)
    end

    # Public: Access the FileSec file section XML nodes
    # 
    # Example
    #
    # @mets.file_sec
    # # => UWDC::FileSec
    #
    # Returns a UWDC::FileSec object
    def file_sec(id=@id)
      @file_sec = FileSec.new(id)
    end

    # Public: Access the DublinCore descriptive metadata XML nodes
    # 
    # Example
    #
    # @mets.dublin_core
    # # => UWDC::DublinCore
    #
    # Returns a UWDC::DublinCore object
    def dublin_core(id=@id)
      @dublin_core = DublinCore.new(id)
    end
    
    # Public: Access the Display class/methods for the METS file
    # 
    # Example
    #
    # @mets.display
    # # => UWDC::Display
    #
    # Returns a UWDC::Display object
    def display(id=@id)
      @display = Display.new(id)
    end
    
    private
    
    # Internal: Strip the id of it's ClassName
    def identifier(id)
      id[0,id.rindex(/[\.-]/)]
    end
    
    # Internal: Remove empty node entries
    def clean_nodes(node_array)
      node_array.map{|node| node.text}.reject(&:empty?)
    end

    # Internal: Select the attribute in a node array
    def pick_attribute(node_array, attribute)
      node_array.map{|node| node.attribute(attribute).value}.reject(&:empty?)
    end
  end
  
  # Public: One division from the StructMap
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

  # Public: One file asset from the FileSec
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