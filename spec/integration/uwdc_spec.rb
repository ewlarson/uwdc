require 'spec_helper'
require 'uwdc'

describe UWDC::Mets do
  before(:each) do
    @id = '33QOBSVPJLWEM8S'
    @mets = UWDC::Mets.new(@id)
    @mods = UWDC::Mods.new(@id)
    @origin = UWDC::Origin.new(@id)
    @rels_ext = UWDC::RelsExt.new(@id)
    @struct_map = UWDC::StructMap.new(@id)
    @file_sec = UWDC::FileSec.new(@id)
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
  
  context 'METS > MODS' do
    it "should return a Nokogiri node set" do
      expect(@mets.mods.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have mods' do
      expect(@mets.mods.nodes.xpath('//mods')).to be_true
    end
    
    [:titles, :dates, :forms, :subjects, :abstracts].each do |attribute|
      it "should respond_to mods attributes - #{attribute}" do
        expect(@mets.mods.send(attribute)).to be_true
      end
    end
  end
  
  context 'METS > StructMap' do
    it "should return a Nokogiri node set" do
      expect(@mets.struct_map).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have RDF' do
      expect(@mets.struct_map.xpath('//div')).to be_true
    end
  end 
  
  context 'MODS' do
    it "should return a Nokogiri node set" do
      expect(@mods.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have mods' do
      expect(@mods.nodes.xpath('//mods')).to be_true
    end
    
    it 'should have titles' do
      expect(@mods.titles).to include('A life idyl')
    end
    
    it 'should have dates' do
      expect(@mods.dates).to include('1869')
    end
    
    it 'should have forms' do
      expect(@mods.forms).to include('text')
    end
    
    it 'should have abstracts' do
      expect(@mods.abstracts).to include(' Green leather with gold stampig on spine and sides. Yellow coated endpapers. All gilt. Simulated raised bands. Gold stamping on board edges and turn-ins.')
    end
    
    it 'should have subjects' do
      expect(@mods.subjects).to be_an_instance_of(Array)
      expect(@mods.subjects).to include('Endpapers--Coated', 'Decoration/Ornament--Lines')
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
  
  context 'StructMap' do
    it "should return a Nokogiri node set" do
      expect(@struct_map.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have RDF' do
      expect(@struct_map.nodes.xpath('//div')).to be_true
    end
    
    it 'should export to XML' do
      expect(Nokogiri::XML(@struct_map.to_xml)).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should export to JSON' do
      expect(JSON.parse(@struct_map.to_json)).to be_an_instance_of(Hash)
      expect(JSON.parse(@struct_map.to_json).keys).to include('structMap')
    end
  end
  
  context 'FileSec' do
    it "should return a Nokogiri node set" do
      expect(@file_sec.nodes).to be_an_instance_of(Nokogiri::XML::NodeSet)
    end
    
    it 'should have RDF' do
      expect(@file_sec.nodes.xpath('//div')).to be_true
    end
    
    it 'should export to XML' do
      expect(Nokogiri::XML(@file_sec.to_xml)).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should export to JSON' do
      expect(JSON.parse(@file_sec.to_json)).to be_an_instance_of(Hash)
      expect(JSON.parse(@file_sec.to_json).keys).to include('fileSec')
    end
  end
end