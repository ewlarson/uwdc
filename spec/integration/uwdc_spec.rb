require 'spec_helper'
require 'uwdc'

describe 'UWDC::Mets' do
  before(:each) do
    @id = '33QOBSVPJLWEM8S'
  end

  context 'METS' do
    xml = UWDC::Mets.new(@id).xml
    it "should return a Nokogiri document" do
      expect(xml).to be_an_instance_of(Nokogiri::XML::Document)
    end
    
    it 'should have mods' do
      expect(xml.xpath('//mods')).to be_true
    end
  end
end