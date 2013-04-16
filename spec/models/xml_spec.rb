# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::XML do
  
  context 'AfricaFocus' do
    it "preload - should have nodes" do
      get_africa_focus_mets
      @mets = UWDC::XML.new(@id,@xml)
      expect(@mets.nodes).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it "httpload - should have nodes" do
      @mets = UWDC::XML.new('ECJ6ZXEYWUE7B8W')
      expect(@mets.nodes).to be_an_instance_of(Nokogiri::XML::Document)
    end
  end
end