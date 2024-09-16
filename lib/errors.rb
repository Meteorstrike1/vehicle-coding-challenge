# frozen_string_literal: true

module Errors
  # Cannot process the registration area
  class InvalidRegistrationArea < StandardError
    attr_reader :message

    def initialize
      super
      @message = 'Invalid registration area'
    end
  end

  # Cannot handle the date
  class InvalidDate < StandardError
    attr_reader :message

    def initialize
      super
      @message = 'Invalid date'
    end
  end

  # Cannot handle the file
  class InvalidFileFormat < StandardError
    attr_reader :message

    def initialize
      super
      @message = 'Invalid file format'
    end
  end
end
