# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

# AfricaFocus - Hyena Wrestler with Muzzled Hyena
def get_africa_focus_mets
  @get  = Nokogiri::XML.parse("../fixtures/africa_focus_mets.xml")
  @id   = 'ECJ6ZXEYWUE7B8W'
end

# Artists' Books - A broth for two parents
def get_artists_books_mets
  @get  = Nokogiri::XML.parse("../fixtures/artists_books_mets.xml")
  @id   = 'CXEB4DPJEOYTM8C'
end

# Publishers' Bindings - A life idyl
def get_publishers_bindings_mets
  @get  = Nokogiri::XML.parse("../fixtures/publishers_bindings_mets.xml")
  @id   = '33QOBSVPJLWEM8S'
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
      get_publishers_bindings_mets
      @mods = UWDC::Mods.new(@id)
    end
    
    supported_mods_attributes.each do |method|
      it { expect(@mods).to respond_to(:"#{method}")}
    end
    
    it "should have an empty names array" do
      expect(@mods.names).to be_an_instance_of(Array)
      expect(@mods.names.empty?).to be_true
    end
    
    it "should have access conditions" do
      supported_mods_attributes.each do |method|
        puts "#{method} => #{@mods.send(method).inspect}"
      end
      expect(@mods.access_conditions.rights).to be_true
      expect(@mods.access_conditions.reuse).to be_true
    end
    
    it "should have related items" do
      expect(@mods.related_items).to be_an_instance_of(Array)
      expect(@mods.related_items.first).to be_true
      expect(@mods.related_items.first).to respond_to(:label)
      expect(@mods.related_items.first).to respond_to(:name)
      expect(@mods.related_items.size).to eq(2)
    end
  end
  
  context 'AfricaFocus' do
    before(:each) do
      get_africa_focus_mets
      @mods = UWDC::Mods.new(@id)
    end
    
    supported_mods_attributes.each do |method|
      it { expect(@mods).to respond_to(:"#{method}")}
    end
    
    it "should have names with roles" do
      expect(@mods.names).to be_an_instance_of(Array)
      expect(@mods.names.empty?).to be_false
      expect(@mods.names.first).to respond_to(:name)
      expect(@mods.names.first).to respond_to(:role)
      expect(@mods.names.size).to eq(1)
    end
    
    it "should have access conditions" do
      expect(@mods.access_conditions.rights).to be_true
      expect(@mods.access_conditions.reuse).to be_true
    end
    
    it "should have related items" do
      expect(@mods.related_items).to be_an_instance_of(Array)
      expect(@mods.related_items.first).to be_true
      expect(@mods.related_items.first).to respond_to(:label)
      expect(@mods.related_items.first).to respond_to(:name)
      expect(@mods.related_items.size).to eq(2)
    end
  end
  
  context 'Artists\' Books' do
    before(:each) do
      get_artists_books_mets
      @mods = UWDC::Mods.new(@id)
    end
    
    supported_mods_attributes.each do |method|
      it { expect(@mods).to respond_to(:"#{method}")}
    end
    
    it "should have names with roles" do
      expect(@mods.names).to be_an_instance_of(Array)
      expect(@mods.names.empty?).to be_false
      expect(@mods.names.first).to respond_to(:name)
      expect(@mods.names.first).to respond_to(:role)
      expect(@mods.names.size).to eq(2)
    end
    
    it "should have empty access conditions" do
      expect(@mods.access_conditions.rights.empty?).to be_true
      expect(@mods.access_conditions.reuse.empty?).to be_true
    end
    
    it "should have related items" do
      expect(@mods.related_items).to be_an_instance_of(Array)
      expect(@mods.related_items.first).to be_true
      expect(@mods.related_items.first).to respond_to(:label)
      expect(@mods.related_items.first).to respond_to(:name)
      expect(@mods.related_items.size).to eq(2)
    end
  end
end