# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')
require 'uwdc'

def klass_methods
  [:mods, :struct_map, :rels_ext, :file_sec, :dublin_core]
end

def formats
  [:to_json, :to_ruby, :to_xml]
end

describe UWDC::Mets do
  context 'PBO' do
    before(:each) do
      get_publishers_bindings_mets
      @mets = UWDC::Mets.new(@id, @xml)
    end
  
    klass_methods.each do |method|
      it { expect(@mets).to respond_to(:"#{method}")}
    end
    
    klass_methods.each do |method|
      formats.each do |format|
        it "should respond to #{method}.#{format}" do
          expect(@mets.send(method)).to respond_to(:"#{format}")
        end
      end
    end
  end
  
  context 'BAD ID' do
    it 'should err on a bad id' do
      expect do
        UWDC::Mets.new('hellhog')
      end.to raise_error(UWDC::XmlNotFound)
    end
  end
end