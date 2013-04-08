module UWDC
  class Mets
    extend HTTPClient::IncludeClient
    include_http_client
    
    attr_accessor :id
    
    def initialize(id)
      @id = id
      @get ||= get
    end
    
    def get
      begin
        response = http_client.get("http://depot.library.wisc.edu/uwdcutils/METS/1711.dl:#{@id}")
        response_xml = Nokogiri::XML.parse(response.body)
        response_xml.remove_namespaces!
      rescue TimeoutError, HTTPClient::ConfigurationError, HTTPClient::BadResponseError, Nokogiri::SyntaxError => e
        exception = e
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
      @rels_ext = RelsExt.new(id).nodes
    end
    
    def file_sec
      @file_sec = FileSec.new
    end
    
    private
    
    def identifier(id)
      id[0,id.rindex(/[\.-]/)]
    end
  end
  
  class Mods < Mets
    def nodes
      @get.xpath("//dmdSec[contains(@ID,'#{@id}')]//mods[1]")
    end
    
    def titles
      nodes.xpath("//mods/titleInfo//title").map{|n| n.text}
    end
    
    def dates
      nodes.xpath("//mods/originInfo//dateIssued").map{|n| n.text}
    end
    
    def forms
      nodes.xpath("//mods/physicalDescription//form").map{|n| n.text}
    end
    
    def abstracts
      nodes.xpath("//mods//abstract").map{|n| n.text}
    end
    
    def subjects
      nodes.xpath("//mods/subject//topic").map{|n| n.text}
    end
    
    def valid?
      response = http_client.get("http://www.loc.gov/standards/mods/mods.xsd")
      xsd = Nokogiri::XML::Schema.new(response.body)
      xml = Nokogiri::XML(nodes.to_xml)
      xsd.valid?(xml)
    end
  end
  
  class Origin < Mets
    def nodes
      @get.xpath("//amdSec[contains(@ID,'#{@id}')]//origin[1]")
    end
  end
  
  class RelsExt < Mets
    def nodes
      @get.xpath("//amdSec[contains(@ID,'#{@id}')]//RDF[1]")
    end
  end
  
  class FileSec < Mets
    def nodes
      @get.xpath("//fileSec")
    end
    
    def files
      nodes.xpath("//fileGrp/file").inject([]){|result, file| result << FileAsset.new(file)}
    end
  end
  
  class StructMap < Mets
    def nodes
      @get.xpath("//structMap[contains(@ID,'#{@id}')]")
    end
    
    def structure
      nodes.xpath('div').inject([]){|result, div| result << Div.new(div)}
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
    attr_accessor :id, :mimetype, :use, :href
    
    def initialize(node)
      @id   = node["ID"]
      @mimetype = node["MIMETYPE"]
      @use      = node["USE"]
      @href     = node.children.detect{|child| child.name == "FLocat"}.attr('href')
    end
  end
end