# frozen_string_literal: true

require_relative 'lib/vehicle_registration_number'
require_relative 'lib/file_handler'
require_relative 'lib/errors'
require 'logger'

LOG = Logger.new($stdout)
LOG.datetime_format = '%H:%M:%S'
LOG.level = Logger::DEBUG

desc 'Load vehicle data and attempt to generate vehicle registration number'
task :generate_vrns do
  filename = 'db/vehicles.csv'

  pass_count = 0
  fail_count = 0
  successful_vrns = []

  imported_csv = FileHandler.load_file_into_hash(filename)
  dataset = VehicleRegistrationNumber.new

  imported_csv.each do |vehicle|
    vrn = dataset.make_vrn(vehicle:)
    area = vehicle['registrationArea']
  rescue Errors::InvalidRegistrationArea, Errors::InvalidDate => e
    fail_count += 1
    LOG.debug { "Failed to generate VRN: #{e.message}" }
  else
    successful_vrns.append({ 'area' => area, 'vrn' => vrn })
    pass_count += 1
  end

  by_area = dataset.total_registrations_by_area(list: successful_vrns)
  uniques = successful_vrns.uniq

  # LOG.info { "Successful VRNs: #{successful_vrns}" }
  LOG.info { "Total number of VRNs successfully generated: #{pass_count}" }
  LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
  LOG.info { "Number of VRNs that could not be determined: #{fail_count}" }
  LOG.info { "Number of duplicate VRNs: #{successful_vrns.length - uniques.length}" }
end

# Not very optimised
desc 'Load vehicle data and attempt to generate vehicle registration number without duplicates'
task :generate_vrns_without_duplicates do
  filename = 'db/vehicles.csv'

  pass_count = 0
  fail_count = 0
  area_fail_count = 0
  date_fail_count = 0
  duplicate_fail_count = 0
  successful_vrns = Set.new

  imported_csv = FileHandler.load_file_into_hash(filename)
  dataset = VehicleRegistrationNumber.new

  imported_csv.each do |vehicle|
    vrn = dataset.make_vrn(vehicle:)
    area = vehicle['registrationArea']
  rescue Errors::InvalidRegistrationArea => e
    area_fail_count += 1
    fail_count += 1
    LOG.debug { "Failed to generate VRN: #{e.message}" }
  rescue Errors::InvalidDate => e
    date_fail_count += 1
    fail_count += 1
    LOG.debug { "Failed to generate VRN: #{e.message}" }
  else
    before_length = successful_vrns.length
    successful_vrns.add({ 'area' => area, 'vrn' => vrn })
    after_length = successful_vrns.length
    if before_length == after_length
      duplicate_fail_count += 1
      fail_count += 1
      LOG.debug { 'Failed to generate VRN: Duplicate entry' }
    else
      pass_count += 1
    end
  end

  by_area = dataset.total_registrations_by_area(list: successful_vrns)

  LOG.info { "Total number of VRNs successfully generated: #{pass_count}" }
  LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
  LOG.info { "Total number of VRNs that could not be determined: #{fail_count}" }
  LOG.info { "Reason for failing: Invalid area = #{area_fail_count}, duplication = #{duplicate_fail_count}, invalid date = #{date_fail_count}" }
end
