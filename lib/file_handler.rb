# frozen_string_literal: true

require_relative 'errors'
require 'csv'
require 'simple_symbolize'

# File handler
module FileHandler
  include Errors
  REQUIRED_HEADERS = %w[make colour dateOfManufacture vin registrationArea].freeze

  def self.load_file_into_hash(filename)
    file = CSV.read(filename)
    raise InvalidFileFormat unless file.first == REQUIRED_HEADERS

    CSV.foreach(filename, headers: true, header_converters: ->(h) { SimpleSymbolize.symbolize(h) }).map(&:to_h)
  end

  def self.create_output_file
    # TODO: Output
  end

end
