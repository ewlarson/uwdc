require 'spec_helper'

describe 'UWDC::Mets' do
  before(:each) do
    @id = '33QOBSVPJLWEM8S'
  end

  it "should return METS" do
    expect(UWDC::Mets.new(@id)).to be_successful
  end
end