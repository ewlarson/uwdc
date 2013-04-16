module UWDC
  class Display
    
    attr_accessor :mets, :title, :visual_representation
    
    def initialize(id, xml=false)
      @mets = UWDC::Mets.new(id,xml)
    end
    
    def use
      {
        "title"                 => { :view => false,  :partial => "text" },
        "visualrepresentation"  => { :view => false,  :partial => "text" },
        "icon"                  => { :view => true,   :partial => "image" },
        "thumb"                 => { :view => true,   :partial => "image" },
        "reference"             => { :view => true,   :partial => "image" },
        "large"                 => { :view => true,   :partial => "image" },
        "audiostream"           => { :view => true,   :partial => "audio" }
      }
    end
    
    def cmodels
      {
        "info:fedora/1711.dl:CModelAudio"                   => { :view => true,   :partial => "audio" },
        "info:fedora/1711.dl:CModelAudioStream"             => { :view => true,   :partial => "audio" },
        "info:fedora/1711.dl:CModelCompositeObject"         => { :view => true,   :partial => "set" },
        "info:fedora/1711.dl:CModelCollection"              => { :view => true,   :partial => "collection" },
        "info:fedora/1711.dl:CModelCompositeObject"         => { :view => false,  :partial => nil },
        "info:fedora/1711.dl:CModelCompositeSequenceObject" => { :view => true,   :partial => "image-with-sequence" },
        "info:fedora/1711.dl:CModelFirstClassObject"        => { :view => false,  :partial => nil },
        "info:fedora/1711.dl:CModelImageWithDefaultRes"     => { :view => true,   :partial => "image" },
        "info:fedora/1711.dl:CModelImageWithDetail"         => { :view => true,   :partial => "image-with-detail" },
        "info:fedora/1711.dl:CModelImageWithSequence"       => { :view => true,   :partial => "image-with-sequence" },
        "info:fedora/1711.dl:CModelImageWithXLarge"         => { :view => true,   :partial => "image-with-xlarge" },
        "info:fedora/1711.dl:CModelImageWithZoom"           => { :view => true,   :partial => "image-with-zoom" },
        "info:fedora/1711.dl:CModelSimpleDocument"          => { :view => true,   :partial => "download" },
        "info:fedora/1711.dl:CModelUWDCObject"              => { :view => false,  :partial => nil }
      }
    end
    
    def files
      @mets.file_sec.files
    end
    
    def images
      viewable_models.inject({}) do |result, model|
        result[model] = files.select{|file| file.id.include?(model) && use[file.use][:partial] == "image"}
        result
      end
    end
    
    def video
    end
    
    def audio
    end
    
    def mods
      @mets.mods
    end
    
    alias :metadata :mods
    
    private
    
    def content_models
      @mets.rels_ext.models
    end

    def viewable_models
      content_models.inject([]) do |result, model|
        result << clean_id(model.first) if model.last.detect{|name| cmodels[name][:view] == true}
        result
      end
    end
    
    def clean_id(id)
      clean = id.split("-")
      "#{clean[0]}-#{clean[1]}"
    end
  end
end