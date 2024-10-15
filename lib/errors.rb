module Errors
  # Cannot process the registration area
  class InvalidRegistrationArea < StandardError

    def initialize(message = 'Invalid registration area')
      super
    end
  end

  # Cannot handle the date
  class InvalidDate < StandardError

    def initialize(message = 'Invalid date')
      super
    end
  end

  # Cannot handle the file
  class InvalidFileFormat < StandardError

    def initialize(message = 'Invalid file format')
      super
    end
  end

  # VRN already exists
  class DuplicateEntryError < StandardError

    def initialize(message = 'VRN must be unique')
      super
    end
  end
end
