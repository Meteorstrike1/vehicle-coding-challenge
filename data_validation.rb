# frozen_string_literal: true

require_relative 'errors'
require 'date'

# Methods and constants for generating and validating sections of the registration number
module DataValidation
  include Errors

  SWANSEA_SECOND_LETTER = %w[A B C D E F G H I J K].freeze
  CARDIFF_SECOND_LETTER = %w[L M N O P Q R S T U V W X Y Z].freeze
  BIRMINGHAM_SECOND_LETTER = %w[A B C].freeze
  RANDOM_LETTERS = %w[A B C D E F G H J L N O P Q R S T U V W X Z].freeze

  def make_area_code(area:)
    case area.downcase
    when 'swansea'
      "C#{SWANSEA_SECOND_LETTER.sample}"
    when 'cardiff'
      "C#{CARDIFF_SECOND_LETTER.sample}"
    when 'birmingham'
      "B#{BIRMINGHAM_SECOND_LETTER.sample}"
    else
      raise InvalidRegistrationArea
    end
  end

  def make_age_id(manufacture_date:)
    date = Date.strptime(manufacture_date, '%d-%m-%Y')
  rescue Date::Error
    raise InvalidDate
  else
    month = date.month
    year = date.year
    without_century = year.to_s[2..]
    if month >= 3 && month <= 8
      without_century
    else
      (without_century.to_i + 50).to_s
    end
  end

  def random_letters
    RANDOM_LETTERS.sample(3).join
  end
end
