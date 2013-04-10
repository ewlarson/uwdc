module UWDC
  class FileSec < Mets
    def nodes
      @get.xpath("//fileSec")
    end
  
    def files
      nodes.xpath("//fileGrp/file").inject([]){|result, file| result << FileAsset.new(file)}
    end
  end
end