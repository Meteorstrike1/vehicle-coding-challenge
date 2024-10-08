# frozen_string_literal: true

require_relative 'lib/vehicle_registration_number'
require_relative 'lib/file_handler'
require_relative 'lib/errors'
require 'logger'

LOG = Logger.new($stdout)
LOG.datetime_format = '%H:%M:%S'
LOG.level = Logger::DEBUG

desc 'Lint the codebase'
task :lint do
  LOG.info { 'Linting with rubocop' }
  sh 'bundle exec rubocop'
end

desc 'Run the rspec tests'
task :tests do
  LOG.info { 'Running rspec tests' }
  sh 'rspec'
end

namespace :registration_numbers do
  desc 'Load vehicle data and attempt to generate vehicle registration number'
  task :generate do
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

    by_area = VehicleRegistrationNumber.total_registrations_by_area(list: successful_vrns)
    uniques = successful_vrns.uniq

    # LOG.info { "Successful VRNs: #{successful_vrns}" }
    LOG.info { "Total number of VRNs successfully generated: #{pass_count}" }
    LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
    LOG.info { "Number of VRNs that could not be determined: #{fail_count}" }
    LOG.info { "Number of duplicate VRNs: #{successful_vrns.length - uniques.length}" }
  end

  desc 'Load vehicle data and attempt to generate vehicle registration number without duplicates'
  task :reject_duplicates do
    filename = 'db/vehicles.csv'

    invalid_vrns = []
    successful_vrns = Set.new

    imported_csv = FileHandler.load_file_into_hash(filename)
    dataset = VehicleRegistrationNumber.new

    imported_csv.each do |vehicle|
      vrn = dataset.make_vrn(vehicle:)
      area = vehicle['registrationArea']
    rescue Errors::InvalidRegistrationArea => e
      invalid_vrns << { reason: 'invalid area' }
      LOG.debug { "Failed to generate VRN: #{e.message}" }
    rescue Errors::InvalidDate => e
      invalid_vrns << { reason: 'invalid date' }
      LOG.debug { "Failed to generate VRN: #{e.message}" }
    else
      if successful_vrns.include?({ 'area' => area, 'vrn' => vrn })
        invalid_vrns << { reason: 'duplicate entry' }
        LOG.debug { 'Failed to generate VRN: Duplicate entry' }
      else
        successful_vrns.add({ 'area' => area, 'vrn' => vrn })
      end
    end

    by_area = VehicleRegistrationNumber.total_registrations_by_area(list: successful_vrns)
    by_invalid_type = VehicleRegistrationNumber.filter_by_invalid_type(invalid_record: invalid_vrns)

    LOG.info { "Total number of VRNs successfully generated: #{successful_vrns.count}" }
    LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
    LOG.info { "Total number of VRNs that could not be determined: #{invalid_vrns.count}" }
    LOG.info { "Reason for failing: #{by_invalid_type}" }
  end
end
