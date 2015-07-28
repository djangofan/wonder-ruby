require 'spec_helper'
require 'pry'

describe Wonder do
  before do
    @wonder = Wonder::Deaths.new
  end

  it 'loads client' do
    expect(@wonder.class).to eq Wonder::Deaths
    expect(@wonder.client.class).to eq Faraday::Connection
  end

  it 'sets the database' do
    expect(@wonder.database).to eq 'ucd-icd10'
  end

  it 'sets the initial parameters' do
    expect(@wonder.request_parameters.keys.size).to eq 69
  end

  it 'sets the request_xml' do
    expect(@wonder.request_xml.length).to eq 5053
  end

  it 'gets the data' do
    VCR.use_cassette('death_default_request') do
      expect(@wonder.get).to eq ''
    end
  end

  it 'parses the default xml' do
    expect(@wonder.default_xml.class).to eq Oga::XML::Document
    binding.pry
  end

end
