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

  context 'request_xml' do
    it 'base no request_object' do
      expect(@wonder.request_object).to eq nil
      expect(@wonder.request_parameters).to eq ({})
      expect(@wonder.request_xml).to eq "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request-parameters><parameter><name>accept_datause_restrictions</name><value>true</value></parameter><parameter><name>action-Send</name><value>Send</value></parameter><parameter><name>stage</name><value>request</value></parameter></request-parameters>"
      expect(@wonder.request_object.class).to eq Builder::XmlMarkup
    end

    it 'request_parameters are simple' do
      @wonder.request_parameters = {'F_D76.V1' => '*All*'}
      expect(@wonder.request_parameters).to eq ({"F_D76.V1"=>"*All*"})
      expect(@wonder.request_object).to eq nil
      expect(@wonder.request_xml).to eq "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request-parameters><parameter><name>accept_datause_restrictions</name><value>true</value></parameter><parameter><name>F_D76.V1</name><value>*All*</value></parameter><parameter><name>action-Send</name><value>Send</value></parameter><parameter><name>stage</name><value>request</value></parameter></request-parameters>"
    end

    it 'request_parameters have an array' do
      @wonder.request_parameters = {'F_D76.V1' => [2010,2011]}
      expect(@wonder.request_parameters).to eq ({'F_D76.V1' => [2010,2011]})
      expect(@wonder.request_object).to eq nil
      expect(@wonder.request_xml).to eq "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request-parameters><parameter><name>accept_datause_restrictions</name><value>true</value></parameter><parameter><name>F_D76.V1</name><value>2010</value><value>2011</value></parameter><parameter><name>action-Send</name><value>Send</value></parameter><parameter><name>stage</name><value>request</value></parameter></request-parameters>"
    end


  end

end
