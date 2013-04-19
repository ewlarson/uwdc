module UWDC
  # Read or Fetch METS XML files 
  class XML
    extend HTTPClient::IncludeClient
    include_http_client
    
    attr_accessor :xml, :nodes, :status
   
    def initialize(id, xml=nil, status=nil)
      @id ||= id
      @xml,@status = http_xml(xml,status)
    end
    
    def http_xml(xml,status)
      unless xml
        begin
          # http://depot.library.wisc.edu:9090/fedora/objects/1711.dl:33QOBSVPJLWEM8S/methods/1711.dl:SDefineFirstClassObject/viewMets
          #response = http_client.get("http://depot.library.wisc.edu/uwdcutils/METS/1711.dl:#{@id}")
          response = http_client.get("http://depot.library.wisc.edu:9090/fedora/objects/1711.dl:#{@id}/methods/1711.dl:SDefineFirstClassObject/viewMets")
          xml = response.body
          status = response.status
        rescue TimeoutError, HTTPClient::ConfigurationError, HTTPClient::BadResponseError, Nokogiri::SyntaxError => error
          exception = error
        end
      end
      [xml,status]
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