require_relative 'lib/data_formatting'
require_relative 'lib/vehicle'
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
  desc 'Load vehicle data and attempt to generate vehicle registration number without duplicates'
  task :reject_duplicates do
    filename = 'db/vehicles.csv'

    vehicles = {}
    invalid_records = []

    imported_csv = FileHandler.load_file_into_hash(filename)

    imported_csv.each do |row|
      new_vehicle = Vehicle.new(row)
      raise Errors::DuplicateEntryError if vehicles[new_vehicle.vrn]

      vehicles[new_vehicle.vrn] = new_vehicle
    rescue Errors::DuplicateEntryError => e
      invalid_records << { reason: 'duplicate entry', data: row }
      LOG.debug { "Failed to generate VRN: #{e}" }
    rescue Errors::InvalidRegistrationArea => e
      invalid_records << { reason: 'invalid area', data: row }
      LOG.debug { "Failed to generate VRN: #{e}" }
    rescue Errors::InvalidDate => e
      invalid_records << { reason: 'invalid date', data: row }
      LOG.debug { "Failed to generate VRN: #{e}" }
    end

    by_area = DataFormatting.filter_by_area(vehicles:)
    by_invalid_type = DataFormatting.filter_by_invalid_type(invalid_records:)

    LOG.info { "Total number of VRNs successfully generated: #{vehicles.count}" }
    LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
    LOG.info { "Total number of VRNs that could not be determined: #{invalid_records.count}" }
    LOG.info { "Reason for failing: #{by_invalid_type}" }
    # FileHandler.create_output_file(vehicles, invalid_records)
  end

  desc 'Load vehicle data and attempt to generate vehicle registration number without duplicates'
  task :retry_duplicates do
    filename = 'db/vehicles.csv'

    vehicles = {}
    invalid_records = []

    imported_csv = FileHandler.load_file_into_hash(filename)

    imported_csv.each do |row|
      new_vehicle = Vehicle.new(row)
      new_vehicle = Vehicle.new(row) while vehicles[new_vehicle.vrn]
      vehicles[new_vehicle.vrn] = new_vehicle
    rescue Errors::DuplicateEntryError => e
      invalid_records << { reason: 'duplicate entry', data: row }
      LOG.debug { "Failed to generate VRN: #{e}" }
    rescue Errors::InvalidRegistrationArea => e
      invalid_records << { reason: 'invalid area', data: row }
      LOG.debug { "Failed to generate VRN: #{e}" }
    rescue Errors::InvalidDate => e
      invalid_records << { reason: 'invalid date', data: row }
      LOG.debug { "Failed to generate VRN: #{e}" }
    end

    by_area = DataFormatting.filter_by_area(vehicles:)
    by_invalid_type = DataFormatting.filter_by_invalid_type(invalid_records:)

    LOG.info { "Total number of VRNs successfully generated: #{vehicles.count}" }
    LOG.info { "Number of VRNs generated per registration area: #{by_area}" }
    LOG.info { "Total number of VRNs that could not be determined: #{invalid_records.count}" }
    LOG.info { "Reasons for failing: #{by_invalid_type}" }
  end
end
