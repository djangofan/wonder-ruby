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
    expect(@wonder.request_xml.length).to eq 4081
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

  context 'by_dates' do

    it 'proper_date?' do
      expect(@wonder.proper_date?('2001/01')).to eq true
      expect(@wonder.proper_date?('2001/1')).to eq false
      expect(@wonder.proper_date?('2001')).to eq true
      expect(@wonder.proper_date?('1981/01')).to eq false
      expect(@wonder.proper_date?('2015')).to eq false
      expect(@wonder.proper_date?(2013)).to eq true
    end

    it 'by_dates' do
      #default
      expect(@wonder.by_dates).to eq '*All*'
      #single year number
      expect(@wonder.by_dates(2010)).to eq 2010
      expect(@wonder.dates).to eq 2010
      #single year with month
      expect(@wonder.by_dates('2010/12')).to eq '2010/12'
      #multiples years
      expect(@wonder.by_dates(['2010', 2011])).to eq ['2010', 2011]
      expect(@wonder.dates).to eq ['2010', 2011]
      #multiples years with months
      expect(@wonder.by_dates(['2010/01', '2011/01'])).to eq ["2010/01", "2011/01"]
    end

    context 'gets with proper dates' do
      it 'gets with single year' do
        @wonder.by_dates(2010)
        expect(@wonder.dates).to eq 2010
        expect(@wonder.default_parameters['F_D76.V1']).to eq 2010
        VCR.use_cassette('deaths_by_date_2010') do
          @wonder.post
        end
        expect(@wonder.data[-1]).to eq ["Total", "2,468,435", "308,745,538", "799.5"]
      end

      it 'gets with single year and month' do
        @wonder.by_dates('2010/01')
        expect(@wonder.dates).to eq '2010/01'
        expect(@wonder.default_parameters['F_D76.V1']).to eq '2010/01'
        VCR.use_cassette('deaths_by_date_2010_01') do
          @wonder.post
        end
        expect(@wonder.data[-1]).to eq ["Total", "222,783", "Not Applicable", "Not Applicable"]
      end

      it 'gets with several years' do
        @wonder.by_dates([2010,2011])
        expect(@wonder.dates).to eq [2010,2011]
        expect(@wonder.default_parameters['F_D76.V1']).to eq [2010,2011]
        VCR.use_cassette('deaths_by_date_2010_2011') do
          @wonder.post
        end
        expect(@wonder.data[-1]).to eq ["Total", "4,983,893", "620,337,455", "803.4"]
      end

      it 'gets with several years and months' do
        @wonder.by_dates(['2010/01','2010/02','2010/03'])
        expect(@wonder.dates).to eq ['2010/01','2010/02','2010/03']
        expect(@wonder.default_parameters['F_D76.V1']).to eq ['2010/01','2010/02','2010/03']
        VCR.use_cassette('deaths_by_date_2010_q1') do
          @wonder.post
        end
        expect(@wonder.data[-1]).to eq ["Total", "641,943", "Not Applicable", "Not Applicable"]
      end


    end


  end

end
