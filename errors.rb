# frozen_string_literal: true

module Errors
  # Cannot process the registration area
  class InvalidRegistrationArea < StandardError
    attr_reader :message

    def initialize(msg = nil)
      super
      @message = 'Invalid registration area'
    end
  end

  class InvalidDate < StandardError
  end
end
