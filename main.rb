# frozen_string_literal: true

require_relative 'registration_generation'
require 'csv'

file = 'vehicles.csv'

data = CSV.foreach(file, headers: true).map(&:to_h)

dataset = RegistrationGeneration.new

dataset.make_vrn(data: data)

sample = dataset.get_successful_vrns

puts sample

puts dataset.get_pass_count
puts dataset.get_fail_count
puts dataset.get_registrations_by_area

list_of_vrns = sample.split(',')

uniqs = list_of_vrns.uniq

puts list_of_vrns.length
puts uniqs.length

puts "Repeats: #{list_of_vrns.length - uniqs.length}"



