# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::FileSec do
  
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @file_sec = UWDC::FileSec.new(@id, @xml)
    end
    
    it "should have files" do
      expect(@file_sec.files).to be_true
      expect(@file_sec.files).to be_an_instance_of(Array)
    end
  end
end