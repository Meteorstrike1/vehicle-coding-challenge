# frozen_string_literal: true

require_relative 'data_validation'

# Generate Vehicle Registration Numbers
class VehicleRegistrationNumber
  include DataValidation

  def make_vrn(vehicle:)
    area = vehicle['registrationArea']
    date = vehicle['dateOfManufacture']
    area_code = make_area_code(area:)
    age_id = make_age_id(manufacture_date: date)
    letters = random_letters
    "#{area_code} #{age_id} #{letters}"
  end

  def self.total_registrations_by_area(list:)
    swansea = 0
    cardiff = 0
    birmingham = 0
    list.each do |hash|
      swansea += 1 if hash['area'] == 'swansea'
      cardiff += 1 if hash['area'] == 'cardiff'
      birmingham += 1 if hash['area'] == 'birmingham'
    end
    "Swansea = #{swansea}, Cardiff = #{cardiff}, Birmingham = #{birmingham}"
  end

  def self.filter_by_invalid_type(invalid_record:)
    invalid_area = invalid_record.select { |record| record[:reason] == 'invalid area' }
    invalid_date = invalid_record.select { |record| record[:reason] == 'invalid date' }
    duplicate_entry = invalid_record.select { |record| record[:reason] == 'duplicate entry' }
    "Invalid area = #{invalid_area.count}, duplication = #{duplicate_entry.count}, invalid date = #{invalid_date.count}"
  end
end
