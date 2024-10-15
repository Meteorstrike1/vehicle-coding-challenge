require_relative 'errors'
require 'csv'
require 'simple_symbolize'
require 'json'
# require 'date_time'

# File handler
module FileHandler
  include Errors
  REQUIRED_HEADERS = %w[make colour dateOfManufacture vin registrationArea].freeze

  def self.load_file_into_hash(filename)
    file = CSV.read(filename)
    raise InvalidFileFormat unless file.first == REQUIRED_HEADERS

    CSV.foreach(filename, headers: true, header_converters: ->(h) { SimpleSymbolize.symbolize(h) }).map(&:to_h)
  end

  # def self.create_output_file(vehicles, invalid_records)
  #   # timestamp = DateTime.now
  #   # output = File.new("output#{timestamp}.csv", 'w')
  #   vehicles.each_value { |vehicle| puts vehicle.as_json }
  #   CSV.open('data.csv', 'w', )
  #
  # end
end
