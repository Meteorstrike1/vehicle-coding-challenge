# frozen_string_literal: true

require_relative 'reg_generation'

# Vehicle object
class Vehicle
  include RegGeneration

  attr_reader :make, :colour, :date_of_manufacture, :vin, :registration_area, :vrn

  def initialize(record)
    @make = record[:make]
    @colour = record[:colour]
    @date_of_manufacture = record[:date_of_manufacture]
    @vin = record[:vin]
    @registration_area = record[:registration_area]
    @vrn = generate_vrn(record)
  end

  def as_json
    {
      make: @make,
      colour: @colour,
      date_of_manufacture: @date_of_manufacture,
      vin: @vin,
      registration_area: @registration_area,
      vrn: @vrn
    }
  end
end
