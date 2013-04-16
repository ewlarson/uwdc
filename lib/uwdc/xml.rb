module UWDC
  class XML
    extend HTTPClient::IncludeClient
    include_http_client
    
    attr_accessor :xml, :nodes
   
    def initialize(id, xml=false)
      @id ||= id
      @xml ||= http_xml(xml)
    end
    
    def http_xml(xml)
      unless xml
        begin
          response = http_client.get("http://depot.library.wisc.edu/uwdcutils/METS/1711.dl:#{@id}")
          xml = response.body
        rescue TimeoutError, HTTPClient::ConfigurationError, HTTPClient::BadResponseError, Nokogiri::SyntaxError => error
          exception = error
        end
      end
      xml
    end
    
    def nodes
      nokogiri_parse(@xml)
    end

    def nokogiri_parse(xml)
      nodes = Nokogiri::XML.parse(xml)
      nodes.remove_namespaces!
    end
  end
end