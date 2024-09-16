# frozen_string_literal: true

require_relative 'data_validation'

# Generate Vehicle Registration Numbers
class VehicleRegistrationNumber
  include DataValidation

  attr_reader :by_area

  def initialize
    super
    @by_area = []
  end

  def total_registrations_by_area
    swansea = @by_area.count('swansea')
    cardiff = @by_area.count('cardiff')
    birmingham = @by_area.count('birmingham')
    "Swansea = #{swansea}, Cardiff = #{cardiff}, Birmingham = #{birmingham}"
  end

  def make_vrn(vehicle:)
    area = vehicle['registrationArea'].downcase
    date = vehicle['dateOfManufacture']
    area_code = make_area_code(area:)
    age_id = make_age_id(manufacture_date: date)
    letters = random_letters
    @by_area.append(area)
    "#{area_code} #{age_id} #{letters}"
  end
end
