# frozen_string_literal: true

# Methods for formatting output
module DataFormatting
  def self.filter_by_area(hash:)
    areas = hash.flatten.map { |object| object.registration_area if object.instance_of?(Vehicle) }
    swansea = areas.count('swansea')
    cardiff = areas.count('cardiff')
    birmingham = areas.count('birmingham')
    "Swansea = #{swansea}, Cardiff = #{cardiff}, Birmingham = #{birmingham}"
  end

  def self.filter_by_invalid_type(invalid_record:)
    invalid_area = invalid_record.select { |record| record[:reason] == 'invalid area' }
    invalid_date = invalid_record.select { |record| record[:reason] == 'invalid date' }
    duplicate_entry = invalid_record.select { |record| record[:reason] == 'duplicate entry' }
    "Invalid area = #{invalid_area.count}, duplication = #{duplicate_entry.count}, invalid date = #{invalid_date.count}"
  end
end
