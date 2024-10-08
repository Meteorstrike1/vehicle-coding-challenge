# frozen_string_literal: true

# Methods for formatting output
module DataFormatting
  def self.filter_by_area(vehicles:)
    areas = vehicles.flatten.filter_map { |object| object.registration_area if object.instance_of?(Vehicle) }
    areas.tally
  end

  def self.filter_by_invalid_type(invalid_records:)
    reasons = invalid_records.map { |record| record[:reason] }
    reasons.tally
  end
end
