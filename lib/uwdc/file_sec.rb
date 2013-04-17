module UWDC
  # Return the METS files
  class FileSec < Mets
    def nodes
      @xml.nodes.xpath("//fileSec")
    end
  
    def files
      nodes.xpath("//fileGrp/file").inject([]){|result, file| result << FileAsset.new(file)}
    end
  end
end