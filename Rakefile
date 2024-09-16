# frozen_string_literal: true

require_relative 'vehicle_registration_number'
require_relative 'file_handler'
require_relative 'errors'
require 'logger'

LOG = Logger.new($stdout)
LOG.datetime_format = '%H:%M:%S'
LOG.level = Logger::DEBUG

desc 'Load vehicle data and attempt to generate vehicle registration number'
task :generate_vrns do
  filename = 'vehicles.csv'

  pass_count = 0
  fail_count = 0
  successful_vrns = []

  imported_csv = FileHandler.load_file_into_hash(filename)
  dataset = VehicleRegistrationNumber.new

  imported_csv.each do |vehicle|
    vrn = dataset.make_vrn(vehicle:)
  rescue Errors::InvalidRegistrationArea, Errors::InvalidDate => e
    fail_count += 1
    LOG.debug { "Failed to generate VRN: #{e.message}" }
  else
    successful_vrns.append(vrn)
    pass_count += 1
  end

  by_area = dataset.total_registrations_by_area
  uniques = successful_vrns.uniq

  # LOG.info { "Successful VRNs: #{successful_vrns}" }
  LOG.info { "Total number of VRNs successfully generated: #{pass_count}" }
  LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
  LOG.info { "Number of VRNs that could not be determined: #{fail_count}" }
  LOG.info { "Number of duplicate VRNs: #{successful_vrns.length - uniques.length}" }
end
