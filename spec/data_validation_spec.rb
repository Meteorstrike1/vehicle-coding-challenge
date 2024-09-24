# frozen_string_literal: true

require_relative '../lib/data_generation'

describe DataGeneration do
  include DataGeneration

  it 'gives the expected area code format for Birmingham' do
    area = 'birmingham'
    regex = /^B[ABC]$/
    result = make_area_code(area:)
    expect(result).to match(regex)
  end

  it 'gives the expected area code format for Swansea' do
    area = 'swansea'
    regex = /^C[A-K]$/
    result = make_area_code(area:)
    expect(result).to match(regex)
  end

  it 'gives the expected area code format for Cardiff' do
    area = 'cardiff'
    regex = /^C[L-Z]$/
    result = make_area_code(area:)
    expect(result).to match(regex)
  end

  it 'gives last 2 year digits' do
    date = '15-03-2012'
    expect(make_age_id(manufacture_date: date)).to eq '12'
  end

  it 'gives last 2 year digits + 50' do
    date = '7-11-2019'
    expect(make_age_id(manufacture_date: date)).to eq '69'
  end

  it 'gives an invalid date error' do
    date = '30-02-2024'
    expect { make_age_id(manufacture_date: date) }.to raise_error(Errors::InvalidDate)
  end

  it "isn't a valid registration area" do
    area = 'london'
    expect { make_area_code(area:) }.to raise_error(Errors::InvalidRegistrationArea)
  end
end
