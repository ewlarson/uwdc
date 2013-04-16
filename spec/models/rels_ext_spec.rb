# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::RelsExt do
  
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @rels_ext = UWDC::RelsExt.new(@id,@xml)
    end
    
    it "should have models" do
      expect(@rels_ext.models).to be_true
      expect(@rels_ext.models).to be_an_instance_of(Hash)
    end
  end
end