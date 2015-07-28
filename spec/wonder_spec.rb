require 'spec_helper'

describe Wonder do
  before do
    @wonder = Wonder::Client.new
  end
  it 'has a version number' do
    expect(Wonder::VERSION).not_to be nil
  end

  it 'loads client' do
    expect(@wonder.class).to eq Wonder::Client
    expect(@wonder.client.class).to eq Faraday::Connection
  end

  it 'request_xml' do
    expect(@wonder.request_xml).to eq "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request-parameters><parameter><name>accept_datause_restrictions</name><value>true</value></parameter><parameter><name>action-Send</name><value>Send</value></parameter><parameter><name>stage</name><value>request</value></parameter></request-parameters>"
  end



end
