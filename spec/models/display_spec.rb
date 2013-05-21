# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

def clean_id(id)
  clean = id.split("-")
  "#{clean[0]}-#{clean[1]}"
end

describe UWDC::Display do
  
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @display = UWDC::Display.new(@id, @xml)
    end
    
    it "should include use attributes" do
      expect(UWDC::Display.use).to be_true
    end
    
    it "should include content models" do
      expect(UWDC::Display.cmodels).to be_true
    end
    
    it "should include files" do
      expect(@display.files).to be_true
    end
    
    it "should include images" do
      expect(@display.images).to be_true
      expect(@display.images.size).to eq(5)
    end
    
    it "should not include audio" do
      expect(@display.audio).to be_empty
    end

    it "should have metadata" do
      expect(@display.metadata).to be_true
      expect(@display.metadata).to be_an_instance_of(UWDC::Mods)
    end
    
    it "should have partials" do
      expect(@display.partials).to be_true
    end
    
    it "should have models" do
      expect(@display.models).to be_true
    end
  end
  
  context 'UNTAC' do
    before(:each) do
      get_untac_archives_mets
      @display = UWDC::Display.new(@id,@xml)
    end
    
    it "should include audio" do
      expect(@display.audio).to be_true
      expect(@display.audio.size).to eq(1)
    end
  end
end