# frozen_string_literal: true

require_relative 'vehicle_registration_number'

# Vehicle object
class Vehicle
  attr_reader :vrn, :make, :colour, :date_of_manufacture, :vin, :registration_area

  def initialize(record)
    @vrn = VehicleRegistrationNumber.new(vehicle: record)
    @make = record['make']
    @colour = record['colour']
    @date_of_manufacture = record['dateOfManufacture']
    @vin = record['vin']
    @registration_area = record['registrationArea']
  end
end
