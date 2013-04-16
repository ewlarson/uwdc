# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::Display do
  
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @display = UWDC::Display.new(@id, @xml)
    end
    
    it "should include use attributes" do
      expect(@display.use).to be_true
    end
    
    it "should include content models" do
      expect(@display.cmodels).to be_true
    end
    
    it "should include files" do
      expect(@display.files).to be_true
    end
    
    it "should include images" do
      expect(@display.images).to be_true
      expect(@display.images.size).to eq(5)
    end
    
    it "should have metadata" do
      expect(@display.metadata).to be_true
      expect(@display.metadata).to be_an_instance_of(Hash)
    end
  end
  
  context 'UNTAC' do
    before(:each) do
      get_untac_archives_mets
      @display = UWDC::Display.new(@id,@xml)
    end
    
    it "should have no images" do
      puts @display.images.inspect
      expect(@display.images).to be_true
      expect(@display.images.size).to eq(0)
    end
  end
end