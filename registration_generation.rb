# frozen_string_literal: true

require_relative 'data_creation'

# Generate Vehicle Registration Number and methods for outputting the results
class RegistrationGeneration
  include DataCreation

  attr_reader :pass_count, :fail_count, :successful_vrns, :by_area

  def initialize
    super
    @pass_count = 0
    @fail_count = 0
    @successful_vrns = []
    @by_area = []
  end

  def get_fail_count
    "Number of vehicles that could not be determined: #{@fail_count}"
  end

  def get_pass_count
    "Total number of VRNs generated: #{@pass_count}"
  end

  def get_successful_vrns
    "Successful VRNs: #{@successful_vrns}"
  end

  def get_registrations_by_area
    swansea = @by_area.count('swansea')
    cardiff = @by_area.count('cardiff')
    birmingham = @by_area.count('birmingham')
    "Number of VRNs generated per registration area:\nSwansea = #{swansea}\nCardiff = #{cardiff}\nBirmingham = #{birmingham}"
  end

  def make_vrn(data:)
    data.each do |hash|
      area = hash['registrationArea'].downcase
      date = hash['dateOfManufacture']
      area_code = make_area_code(area: area)
      age_id = make_age_id(manufacture_date: date)
    rescue InvalidRegistrationArea => e
      puts e.message
      @fail_count += 1
    rescue InvalidDate
      @fail_count += 1
    else
      letters = random_letters
      vrn = "#{area_code} #{age_id} #{letters}"
      @by_area.append(area)
      @successful_vrns.append(vrn)
      @pass_count += 1
    end
  end
end
