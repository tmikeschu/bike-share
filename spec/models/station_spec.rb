require_relative '../spec_helper'

#test that Station.first returns a Station
#test that Station.first returns the Station we expect

#test that Station.first.city returns a City
#test that Station.first.city returns the City we expect

#test that Station.first.departure_trips returns some Trips
#test that Station.first.departure_trips returns the Trips we expect

#test that Station.first.arrival_trips returns some Trips
#test that Station.first.arrival_trips returns the Trips we expect

describe 'Station' do

  before do
    City.create(name: "Denver")
  end

  describe 'validates' do
    it 'presence of station name' do
      invalid_station = City.first.stations.create(dock_count: 27, installation_date: "10/6/2015", lat: 37.329732, long: -121.90178200000001)
      expect(invalid_station).to be_invalid
    end

    it 'presence of the dock count' do
      invalid_station = City.first.stations.create(name: "I Like Bike", installation_date: "10/6/2015", lat: 37.329732, long: -121.90178200000001)
      expect(invalid_station).to be_invalid
    end

    it 'presence of a city_id' do
      invalid_station = Station.create(name: "I Like Bike", dock_count: 27, installation_date: "10/6/2015", lat: 37.329732, long: -121.90178200000001)
      expect(invalid_station).to be_invalid
    end

    it 'presence of a latitude' do
      invalid_station = Station.create(name: "I Like Bike", dock_count: 27, installation_date: "10/6/2015", long: -121.90178200000001)
      expect(invalid_station).to be_invalid
    end

    it 'presence of a longitude' do
      invalid_station = Station.create(name: "I Like Bike", dock_count: 27, installation_date: "10/6/2015", lat: 37.329732)
      expect(invalid_station).to be_invalid
    end
  end
end
