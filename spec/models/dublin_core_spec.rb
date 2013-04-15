# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::DublinCore do
  
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @dublin_core = UWDC::DublinCore.new(@id)
    end
    
    it "should have a titles" do
      puts @dublin_core.titles.inspect
      expect(@dublin_core.titles).to be_true
      expect(@dublin_core.titles).to be_an_instance_of(Array)
      expect(@dublin_core.titles.size).to eq(1)
    end
  end
end