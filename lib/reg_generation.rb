# frozen_string_literal: true

require_relative 'errors'
require 'date'
require 'simple_symbolize'

# Methods and constants for generating sections of the registration number
module RegGeneration
  include Errors

  # Original approach
  SWANSEA_SECOND_LETTER = %w[A B C D E F G H I J K].freeze
  CARDIFF_SECOND_LETTER = %w[L M N O P Q R S T U V W X Y Z].freeze
  BIRMINGHAM_SECOND_LETTER = %w[A B C].freeze
  RANDOM_LETTERS = %w[A B C D E F G H J L N O P Q R S T U V W X Z].freeze

  # Alternative approach, assume receive a file of patterns per area
  VRN_AREA_PATTERNS = {
    swansea: %w[CA CB CC CD CE CF CG CH CI CJ CK],
    cardiff: %w[CL CM CN CO CP CQ CR CS CT CU CV CW CX CY CZ],
    birmingham: %w[BA BB BC]
  }.freeze

  # Original approach for area code
  def area_code_original(area:)
    area = SimpleSymbolize.symbolize(area) unless area.is_a?(Symbol)
    case area
    when :swansea
      "C#{SWANSEA_SECOND_LETTER.sample}"
    when :cardiff
      "C#{CARDIFF_SECOND_LETTER.sample}"
    when :birmingham
      "B#{BIRMINGHAM_SECOND_LETTER.sample}"
    else
      raise InvalidRegistrationArea
    end
  end

  # Alternative approach for area code
  def area_code(area:)
    area = SimpleSymbolize.symbolize(area) unless area.is_a?(Symbol)
    VRN_AREA_PATTERNS[area].sample
  rescue NoMethodError
    raise InvalidRegistrationArea
  end

  def age_id(manufacture_date:)
    date = Date.strptime(manufacture_date, '%d-%m-%Y')
  rescue Date::Error
    raise InvalidDate
  else
    month = date.month
    year = date.strftime('%y')
    march_to_august = (3..8)
    march_to_august.include?(month) ? year : (year.to_i + 50).to_s
  end

  def random_letters
    RANDOM_LETTERS.sample(3).join
  end

  def generate_vrn(record)
    "#{area_code(area: record[:registration_area])} #{age_id(manufacture_date: record[:date_of_manufacture])} #{random_letters}"
  end
end
