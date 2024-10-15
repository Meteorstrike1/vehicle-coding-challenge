# Methods for formatting output
module DataFormatting
  def self.filter_by_area(vehicles:)
    vehicles.flatten.filter_map { |object| object.registration_area if object.instance_of?(Vehicle) }.tally
  end

  def self.filter_by_invalid_type(invalid_records:)
    invalid_records.map { |record| record[:reason] }.tally
  end
end
