# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::StructMap do
  
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @struct_map = UWDC::StructMap.new(@id,@xml)
    end
    
    it "should have structure" do
      expect(@struct_map.structure).to be_true
      expect(@struct_map.structure).to be_an_instance_of(Array)
    end
  end
end