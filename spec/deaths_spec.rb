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
    expect(@wonder.database).to eq 'D76'
  end

  it 'sets the initial parameters' do
    expect(@wonder.request_parameters.keys.size).to eq 59
  end

  it 'sets the request_xml' do
    expect(@wonder.request_xml.length).to eq 4075
  end

  it 'gets the data' do
    VCR.use_cassette('death_default_request') do
      @wonder.post
      expect(@wonder.data).to eq [["< 1 year", "23,440", "3,941,783", "594.7"], ["1-4 years", "4,068", "15,926,305", "25.5"], ["5-14 years", "5,340", "41,221,035", "13.0"], ["15-24 years", "28,486", "43,954,402", "64.8"], ["25-34 years", "45,463", "42,844,587", "106.1"], ["35-44 years", "69,573", "40,452,690", "172.0"], ["45-54 years", "177,724", "43,767,532", "406.1"], ["55-64 years", "338,127", "39,316,431", "860.0"], ["65-74 years", "454,429", "25,216,766", "1,802.1"], ["75-84 years", "625,013", "13,446,519", "4,648.1"], ["85+ years", "825,198", "6,040,789", "13,660.4"], ["Not Stated", "132", "Not Applicable", "Not Applicable"], ["Total", "2,596,993", "316,128,839", "821.5"]]
    end
  end

  context 'group_by' do

    it 'groups_by indicator' do
      @wonder.group_by('D76.V7')
      expect(@wonder.group_by_parameters).to eq ({"B_1"=>"D76.V7", "B_2"=>"*None*", "B_3"=>"*None*", "B_4"=>"*None*", "B_5"=>"*None*"})
      @wonder.group_by('D76.V7', 'D76.V21','D76.V8','D76.V9-level2','D76.V1-level1')
      expect(@wonder.group_by_parameters).to eq ({"B_1"=>"D76.V7", "B_2"=>"D76.V21", "B_3"=>"D76.V8", "B_4"=>"D76.V9-level2", "B_5"=>"D76.V1-level1"})
    end

    it 'raises error for more than 5' do
      expect {
        @wonder.group_by('D76.V7', 'D76.V21','D76.V8','D76.V9-level2','D76.V1-level1', 'D76.V22')
      }.to raise_error
    end

    it 'raises error if param isn\'t in approved list' do
      expect {
        @wonder.group_by('D76.V700')
      }.to raise_error
    end
  end

end
