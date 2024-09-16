# require 'rspec/autorun'
require_relative '../data_creation'

describe DataCreation do
  include DataCreation

  it "gives a number" do
    date = '15-03-2012'
    expect(make_age_id(manufacture_date: date)).to eq '12'
  end

  it "gives a number" do
    date = '7-11-2019'
    expect(make_age_id(manufacture_date: date)).to eq '69'
  end

  it "gives an error" do
    date = '30-02-2024'
    expect { make_age_id(manufacture_date: date) }.to raise_error(Errors::InvalidDate)
  end

  it "isn't valid registration area" do
    area = 'london'
    expect { make_area_code(area: area) }.to raise_error(Errors::InvalidRegistrationArea)
  end
end


