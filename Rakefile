require "bundler"
Bundler.require
require 'smarter_csv'

require "sinatra/activerecord/rake"

require File.expand_path('../config/environment', __FILE__)


namespace :import do
  desc "Import station.csv to cities table"
  task :cities do
   create_cities
  end

  desc "Import station.csv to table"
  task :stations do
   create_stations
  end

  #insert other tasks...

end

def create_cities
  cities = SmarterCSV.process('db/csv/station.csv').map do |row|
    row[:city]
  end.uniq

  cities.each do |city|
    City.create(name: city)
  end

  puts "Imported Cities to Table."
end

def create_stations
  def format_date(date)
    date = date.split("/").reverse
    date[1], date[2] = date[2], date[1]
    date = date.join("/")
    date
  end

  SmarterCSV.process('db/csv/station.csv').each do |row|
    row[:installation_date] = format_date(row[:installation_date])
    p row[:city]

  end

  puts "Imported Stations to Table."
end

#insert other create_table_names...
