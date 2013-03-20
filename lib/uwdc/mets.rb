module UWDC
  class Mets
    extend HTTPClient::IncludeClient
    include_http_client
    
    def initialize(id)
      @id = id
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
    
    def xml
      get
    end
    
    def to_json
      Hash.from_xml(xml.to_xml).to_json
    end
    
    def to_ruby
      Hash.from_xml(xml.to_xml)
    end
    
    def to_xml
      xml.to_xml
    end
  end
  
  class Mods < Mets
    def xml
      get.xpath("//dmdSec[contains(@ID,'#{@id}')]//mods[1]")
    end
  end
  
  class Origin < Mets
    def xml
      get.xpath("//amdSec[contains(@ID,'#{@id}')]//origin[1]")
    end
  end
  
  class RelsExt < Mets
    def xml
      get.xpath("//amdSec[contains(@ID,'#{@id}')]//RDF[1]")
    end
  end
end