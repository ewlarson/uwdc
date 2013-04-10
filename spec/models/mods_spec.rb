# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

# PBO - A life idyl
def get_pbo_mets
  @get  = Nokogiri::XML.parse("../fixtures/pbo_mets.xml")
  @id   = '33QOBSVPJLWEM8S'
end

# AfricaFocus - Hyena Wrestler with Muzzled Hyena
def get_af_mets
  @get  = Nokogiri::XML.parse("../fixtures/af_mets.xml")
  @id   = 'ECJ6ZXEYWUE7B8W'
end

# Artists' Books - A broth for two parents
def get_ab_mets
  @get  = Nokogiri::XML.parse("../fixtures/artists_books_mets.xml")
  @id   = 'CXEB4DPJEOYTM8C'
end

def supported_mods_attributes
  [
    :titles, 
    :names,
    :dates,
    :forms,
    :abstracts,
    :subjects,
    :subjects_heirarchical_geographic,
    :access_conditions,
    :related_items
  ]
end

describe UWDC::Mods do
  
  context 'PBO' do
    before(:each) do
      get_pbo_mets
      @mods = UWDC::Mods.new(@id)
    end
    
    supported_mods_attributes.each do |method|
      it { expect(@mods).to respond_to(:"#{method}")}
    end
    
    it "should have an empty names array" do
      expect(@mods.names).to be_an_instance_of(Array)
      expect(@mods.names.empty?).to be_true
    end
  end
  
  context 'AfricaFocus' do
    before(:each) do
      get_af_mets
      @mods = UWDC::Mods.new(@id)
    end
    
    it "should have names with roles" do
      expect(@mods.names).to be_an_instance_of(Array)
      expect(@mods.names.empty?).to be_false
      expect(@mods.names.first).to respond_to(:name)
      expect(@mods.names.first).to respond_to(:role)
    end
  end
  
  context 'Artists\' Books' do
    before(:each) do
      get_ab_mets
      @mods = UWDC::Mods.new(@id)
    end
    
    it "should have names with roles" do
      expect(@mods.names).to be_an_instance_of(Array)
      expect(@mods.names.empty?).to be_false
      expect(@mods.names.first).to respond_to(:name)
      expect(@mods.names.first).to respond_to(:role)
      expect(@mods.names.size).to eq(2)
    end
  end
end