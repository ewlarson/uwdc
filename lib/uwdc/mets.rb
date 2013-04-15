module UWDC
  # Obtain UWDC METS metadata via an object identifier.
  class Mets
    extend HTTPClient::IncludeClient
    include_http_client
    
    attr_accessor :id
    
    # Intialize a UWDC Mets object
    #
    # @param [String] id of the object
    def initialize(id)
      @id = id
      @get ||= get
    end
    
    # HTTP request for the Fedora Commons held METS
    #
    # @return [Nokogiri::Document] the resulting METS XML as a Nokogiri document
    
    def get
      begin
        response = http_client.get("http://depot.library.wisc.edu/uwdcutils/METS/1711.dl:#{@id}")
        response_xml = Nokogiri::XML.parse(response.body)
        response_xml.remove_namespaces!
      rescue TimeoutError, HTTPClient::ConfigurationError, HTTPClient::BadResponseError, Nokogiri::SyntaxError => error
        exception = error
      end
    end
    
    alias :nodes :get
    
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