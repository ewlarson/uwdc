module UWDC
  # Public: Return an object to drive the display of UWDC items
  #
  # Example
  #
  # @display = UWDC::Display.new('33QOBSVPJLWEM8S')
  # # => object
  class Display
    
    attr_accessor :mets, :title, :visual_representation
    
    def initialize(id, xml=nil)
      @mets = UWDC::Mets.new(id,xml)
    end
    
    def self.use
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
    
    def self.cmodels
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
    
    def image_files(model)
      files.select{|file| file.id.include?(model) && UWDC::Display.use[file.use][:partial] == "image"}
    end
    
    def images
      viewable_models.inject({}) do |result, model|
        result[model] = image_files(model)
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
    
    # @TODO: 
    # Public: Partials is the intersection of the struct_map and the object cmodels
    # Need to preserve the struct map's "div" structure
    # But also tease out which objects are displayable via which partials
    # 
    # Return an array of Hashes (possibly nested) of ids keying to view partials
    def partials
      @mets.struct_map.structure
    end
    
    def models
      @mets.rels_ext.models
    end

    alias :metadata :mods
    
    private
    
    def content_models
      @mets.rels_ext.models
    end
    
    def viewable_model?(model)
      model.last.detect{|name| UWDC::Display.cmodels[name][:view] == true}
    end

    def viewable_models
      content_models.inject([]) do |result, model|
        result << clean_id(model.first) if viewable_model?(model)
        result
      end
    end
    
    def clean_id(id)
      clean = id.split("-")
      "#{clean[0]}-#{clean[1]}"
    end
  end
end