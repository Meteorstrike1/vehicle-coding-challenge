# frozen_string_literal: true

require_relative 'errors'
require 'csv'

# File handler
module FileHandler
  include Errors
  REQUIRED_HEADERS = %w[make colour dateOfManufacture vin registrationArea].freeze

  def self.load_file_into_hash(filename)
    file = CSV.read(filename)
    raise InvalidFileFormat unless file.first == REQUIRED_HEADERS

    CSV.foreach(filename, headers: true).map(&:to_h)
  end
end
