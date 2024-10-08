# frozen_string_literal: true

require_relative '../lib/reg_generation'

describe RegGeneration do
  include RegGeneration

  it 'gives the expected area code format for Birmingham' do
    area = 'birmingham'
    regex = /^B[ABC]$/
    result = area_code(area:)
    expect(result).to match(regex)
  end

  it 'gives the expected area code format for Swansea' do
    area = 'swansea'
    regex = /^C[A-K]$/
    result = area_code(area:)
    expect(result).to match(regex)
  end

  it 'gives the expected area code format for Cardiff' do
    area = 'cardiff'
    regex = /^C[L-Z]$/
    result = area_code(area:)
    expect(result).to match(regex)
  end

  it 'gives last 2 year digits' do
    date = '15-03-2012'
    expect(age_id(manufacture_date: date)).to eq '12'
  end

  it 'gives last 2 year digits + 50' do
    date = '7-11-2019'
    expect(age_id(manufacture_date: date)).to eq '69'
  end

  it 'gives valid random letters' do
    regex = /^[A-HJLN-XZ]{3}$/
    expect(random_letters).to match regex
  end

  it 'gives the expected vrn format for a valid vehicle from Cardiff' do
    record = { registration_area: 'cardiff', date_of_manufacture: '7-11-2018' }
    regex = /^C[L-Z] 68 [A-HJLN-XZ]{3}$/
    expect(generate_vrn(record)).to match regex
  end

  it 'gives an invalid date error' do
    date = '30-02-2024'
    expect { age_id(manufacture_date: date) }.to raise_error(Errors::InvalidDate)
  end

  it "isn't a valid registration area" do
    area = 'london'
    expect { area_code(area:) }.to raise_error(Errors::InvalidRegistrationArea)
  end
end
