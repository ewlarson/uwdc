# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

describe UWDC::Origin do
  
  context 'AfricaFocus' do
    before(:each) do
      get_africa_focus_mets
      @origin = UWDC::Origin.new(@id,@xml)
    end
    
    it "should have a submitter" do
      expect(@origin.submitters).to be_an_instance_of(Array)
      expect(@origin.submitters).to be_true
      expect(@origin.submitters.size).to eq(1)
    end
  end
end