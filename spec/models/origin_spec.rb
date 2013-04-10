# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

# AfricaFocus - Hyena Wrestler with Muzzled Hyena
def get_africa_focus_mets
  @get  = Nokogiri::XML.parse("../fixtures/africa_focus_mets.xml")
  @id   = 'ECJ6ZXEYWUE7B8W'
end

describe UWDC::Origin do
  
  context 'AfricaFocus' do
    before(:each) do
      get_africa_focus_mets
      @origin = UWDC::Origin.new(@id)
    end
    
    it "should have a submitter" do
      expect(@origin.submitters).to be_an_instance_of(Array)
      expect(@origin.submitters).to be_true
      expect(@origin.submitters.size).to eq(1)
    end
  end
end