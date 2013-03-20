require 'spec_helper'
require 'uwdc'

describe UWDC::Mets do
  before(:each) do
    @id = '33QOBSVPJLWEM8S'
    @mods = UWDC::Mods.new(@id)
    @origin = UWDC::Origin.new(@id)
    @rels_ext = UWDC::RelsExt.new(@id)
  end

  context 'METS' do
    mets = UWDC::Mets.new(@id)
    it "should return a Nokogiri document" do
      expect(mets.nodes).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should have mets' do
      expect(mets.nodes.xpath('//mets')).to be_true
    end
  end
  
  context 'MODS' do
    it "should return a Nokogiri node set" do
      expect(@mods.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have mods' do
      expect(@mods.nodes.xpath('//mods')).to be_true
    end
    
    it 'should export to XML' do
      expect(Nokogiri::XML(@mods.to_xml)).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should be valid MODS XML' do
      expect(@mods.valid?).to be_true
    end
    
    it 'should export to JSON' do
      expect(JSON.parse(@mods.to_json)).to be_an_instance_of(Hash)
      expect(JSON.parse(@mods.to_json).keys).to include('mods')
    end
    
    it 'should export to ruby' do
      expect(@mods.to_ruby).to be_an_instance_of(Hash)
    end
  end
  
  context 'ORIGIN' do
    it "should return a Nokogiri node set" do
      expect(@origin.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have origin' do
      expect(@origin.nodes.xpath('//origin')).to be_true
    end
    
    it 'should export to XML' do
      expect(Nokogiri::XML(@origin.to_xml)).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should export to JSON' do
      expect(JSON.parse(@origin.to_json)).to be_an_instance_of(Hash)
      expect(JSON.parse(@origin.to_json).keys).to include('origin')
    end
  end
  
  context 'RelsExt' do
    it "should return a Nokogiri node set" do
      expect(@rels_ext.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have RDF' do
      expect(@rels_ext.nodes.xpath('//RDF')).to be_true
    end
    
    it 'should export to XML' do
      expect(Nokogiri::XML(@rels_ext.to_xml)).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should export to JSON' do
      expect(JSON.parse(@rels_ext.to_json)).to be_an_instance_of(Hash)
      expect(JSON.parse(@rels_ext.to_json).keys).to include('RDF')
    end
  end
end