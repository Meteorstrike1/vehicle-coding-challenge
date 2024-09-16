# frozen_string_literal: true

require_relative 'vehicle'
require_relative 'file_handler'
require 'logger'

task :first_task do
  filename = 'vehicles.csv'

  imported_csv = FileHandler.load_file_into_hash(filename)

  dataset = Vehicle.new

  imported_csv.each do |vehicle|
    dataset.make_vrn(vehicle: vehicle)
  end

  sample = dataset.list_successful_vrns

  puts sample

  puts dataset.total_pass_count
  puts dataset.total_fail_count
  puts dataset.total_registrations_by_area

  list_of_vrns = sample.split(',')

  uniqs = list_of_vrns.uniq

  puts list_of_vrns.length
  puts uniqs.length

  puts "Repeats: #{list_of_vrns.length - uniqs.length}"
end
