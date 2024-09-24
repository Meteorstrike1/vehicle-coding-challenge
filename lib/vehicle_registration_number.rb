# frozen_string_literal: true

require_relative 'data_generation'

# Generate Vehicle Registration Number
class VehicleRegistrationNumber
  include DataGeneration

  attr_reader :vrn

  def initialize(vehicle:)
    area = vehicle['registrationArea']
    date = vehicle['dateOfManufacture']
    area_code = make_area_code(area:)
    age_id = make_age_id(manufacture_date: date)
    letters = random_letters
    @vrn = "#{area_code} #{age_id} #{letters}"
  end

  def to_s
    @vrn
  end
end
