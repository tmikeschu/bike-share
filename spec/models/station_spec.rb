require_relative '../spec_helper'

describe 'Station' do

  before do
    %w(Denver Aurora Centennial).each {|city| City.create(name: city) }
    %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
    denver, aurora, centennial = City.find(1), City.find(2), City.find(3)
    denver.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:01:00", lat: 37.329732, long: -121.901782)
    denver.stations.create(name: "San Jose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    aurora.stations.create(name: "Jan Sose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    aurora.stations.create(name: "Jan Sose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    centennial.stations.create(name: "Naj Esos Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    centennial.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 1, end_date: "2013-08-29", end_station_id: 2, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 4, bike_id: 501, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-07-30", start_station_id: 6, end_date: "2013-07-30", end_station_id: 1, bike_id: 50, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2014-08-09", start_station_id: 4, end_date: "2014-08-10", end_station_id: 3, bike_id: 52, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-01-02", start_station_id: 6, end_date: "2013-01-10", end_station_id: 5, bike_id: 20, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "1992-02-11", start_station_id: 6, end_date: "1992-02-11", end_station_id: 6, bike_id: 131, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
  end

  describe 'validates' do
    it 'presence of station name' do
      invalid_station = City.first.stations.create(dock_count: 27, installation_date: "10/6/2015", lat: 37.329732, long: -121.90178200000001)
      expect(invalid_station).to be_invalid
    end

    it 'uniqueness of name' do
      City.first.stations.create(name: "Union", dock_count: 27, installation_date: "10/6/2015", lat: 37.329732, long: -121.90178200000001)
      invalid_station = City.first.stations.create(name: "Union", dock_count: 28, installation_date: "10/8/2015", lat: 39.329732, long: -123.90178200000001)
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

    it 'presence of an installation_date' do
      invalid_station = City.first.stations.create(name: "I Like Bike", dock_count: 27, lat: 37.329732, long: -121.90178200000001)
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

  describe "associations" do
    it "#departure_trips returns expected trips for a station" do
      station = Station.first
      station_trips = Trip.where(start_station: station)
      expect(station.departure_trips).to eq(station_trips)
      expect(station.departure_trips.all.all?{|trip| trip.class.to_s == "Trip"}).to be true
    end

    it "and #departure_trips returns expected trips for a different station" do
      station = Station.all[1]
      station_trips = Trip.where(start_station: station)
      expect(station.departure_trips).to eq(station_trips)
      expect(station.departure_trips.all.all?{|trip| trip.class.to_s == "Trip"}).to be true
    end

    it "and one more different station" do
      station = Station.all[3]
      station_trips = Trip.where(start_station: station)
      expect(station.departure_trips).to eq(station_trips)
      expect(station.departure_trips.all.all?{|trip| trip.class.to_s == "Trip"}).to be true
    end

    it "#arrival_trips returns expected trips for a station" do
      station = Station.first
      station_trips = Trip.where(end_station: station)
      expect(station.arrival_trips).to eq(station_trips)
      expect(station.arrival_trips.all.all?{|trip| trip.class.to_s == "Trip"}).to be true
    end

    it "and #arrival_trips returns expected trips for a different station" do
      station = Station.all[1]
      station_trips = Trip.where(end_station: station)
      expect(station.arrival_trips).to eq(station_trips)
      expect(station.arrival_trips.all.all?{|trip| trip.class.to_s == "Trip"}).to be true
    end

    it "and one more different station" do
      station = Station.all[3]
      station_trips = Trip.where(end_station: station)
      expect(station.arrival_trips).to eq(station_trips)
      expect(station.arrival_trips.all.all?{|trip| trip.class.to_s == "Trip"}).to be true
    end

    it "#city returns city" do
      city = City.first
      city_stations = Station.where(city: city)
      expect(city.stations).to eq(city_stations)
      expect(city.stations.all.all?{|station| station.class.to_s == "Station"}).to be true
    end

    it "and #city returns city for a different station" do
      city = City.all[2]
      city_stations = Station.where(city: city)
      expect(city.stations).to eq(city_stations)
      expect(city.stations.all.all?{|station| station.class.to_s == "Station"}).to be true
    end

  end
end

describe 'Station Methods' do

  before do
    denver = City.create(name: "Denver")
    denver.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    denver.stations.create(name: "San Jose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    denver.stations.create(name: "Balboa Park Station", dock_count: 6, installation_date: "2014-04-11 00:00:00", lat: 38.335698, long: -122.888009)
  end

  describe "station methods" do
    it "total_station_count returns count of all stations" do
      count = Station.total_station_count
      expect(count).to be_instance_of Fixnum
      expect(count).to eq(3)
    end

    it "average_bikes_per_station returns average number of docks per station" do
      average = Station.average_bikes_per_station
      expect(average).to be_instance_of Fixnum
      expect(average).to eq(16)
    end

    it "maximum_bikes_per_station highest dock number" do
      max = Station.maximum(:dock_count)
      expect(max).to be_instance_of Fixnum
      expect(max).to eq(27)
    end

    it "minimum_bikes_per_station returns lowest dock number" do
      min = Station.minimum_bikes_per_station
      expect(min).to be_instance_of Fixnum
      expect(min).to eq(6)
    end

    it "stations_with_maximum_bikes_available returns stations with most docks" do
      stations = Station.stations_with_maximum_bikes_available
      expect(stations).to be_instance_of Array
      expect(stations).to eq(["San Jose Diridon Caltrain Station"])
    end

    it "stations_with_minimum_bikes_available returns stations with least docks" do
      stations = Station.stations_with_minimum_bikes_available
      expect(stations).to be_instance_of Array
      expect(stations).to eq(["Balboa Park Station"])
    end

    it "newest_station returns station with most recent installation_date" do
      newest = Station.newest_station
      expect(newest).to be_instance_of String
      expect(newest).to eq("Balboa Park Station")
    end

    it "oldest_station returns station with least recent installation date" do
      oldest = Station.oldest_station
      expect(oldest).to be_instance_of String
      expect(oldest).to eq("San Jose Civic Center")
    end



  end
end
