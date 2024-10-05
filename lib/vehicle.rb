# frozen_string_literal: true

require_relative 'reg_generation'

# Vehicle object
class Vehicle
  include RegGeneration

  attr_reader :vrn, :make, :colour, :date_of_manufacture, :vin, :registration_area

  def initialize(record)
    @vrn = "#{area_code(area: record[:registration_area])} #{age_id(manufacture_date: record[:date_of_manufacture])} #{random_letters}"
    @make = record[:make]
    @colour = record[:colour]
    @date_of_manufacture = record[:date_of_manufacture]
    @vin = record['vin']
    @registration_area = record[:registration_area]
  end
end
