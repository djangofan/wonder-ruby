require 'spec_helper'

describe Wonder do

  it 'loads client' do
    @wonder = Wonder::Births.new
    expect(@wonder.class).to eq Wonder::Births
    expect(@wonder.client.class).to eq Faraday::Connection
  end

end
