require_relative '../spec_helper'

describe 'Weather Conditions' do
  
  before do
    %w(Denver Aurora Centennial).each {|city| City.create(name: city) }
    %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
    denver, aurora, centennial = City.find(1), City.find(2), City.find(3)
    denver.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    denver.stations.create(name: "San Jose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    aurora.stations.create(name: "Jan Sose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    aurora.stations.create(name: "Jan Sose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)    
    centennial.stations.create(name: "Naj Esos Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    centennial.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 1, end_date: "2013-08-29", end_station_id: 2, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 4, bike_id: 520, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-07-30", start_station_id: 5, end_date: "2013-07-30", end_station_id: 1, bike_id: 520, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2014-08-09", start_station_id: 4, end_date: "2014-08-10", end_station_id: 3, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-01-02", start_station_id: 3, end_date: "2013-01-10", end_station_id: 5, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "1992-02-11", start_station_id: 6, end_date: "1992-02-11", end_station_id: 6, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    WeatherCondition.create(date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 10, mean_wind_speed_mph: 11, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 10, mean_wind_speed_mph: 11, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 10, mean_wind_speed_mph: 11, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 10, mean_wind_speed_mph: 11, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 10, mean_wind_speed_mph: 11, precipitation_inches: 0.0, zip_code: 94107)
  end
  
  describe "trip associations" do
    it ":trips returns expected trips for a condition" do
      condition = WeatherCondition.first
      condition_trips = Trip.where(start_date: condition.date)
      expect(condition.trips).to eq(condition_trips)
    end
    
    it "and :trips returns expected trips for a different condition" do
      condition = WeatherCondition.all[1]
      condition_trips = Trip.where(start_date: condition.date)
      expect(condition.trips).to eq(condition_trips)
    end
    
    it "and one more different condition" do
      condition = WeatherCondition.all[3]
      condition_trips = Trip.where(start_date: condition.date)
      expect(condition.trips).to eq(condition_trips)
    end

  end
  
  describe "analytics" do
    it ".trips_on_days returns a hash of dates pointing to trip count'" do
      conditions = WeatherCondition
      trips = Trip.all.all
      trips = trips.reduce({}) do |result, trip|
        result[trip.start_date] = 0 unless result[trip.start_date]
        result[trip.start_date] += 1
        result
      end
      expect(WeatherCondition.trips_on_days(WeatherCondition.all)).to eq(trips)
    end

    it ".trips_on_days works on a specified conditions range'" do
      conditions = WeatherCondition.where(max_temperature_f: [70..79])
      trips = Trip.all.find_all {|trip| trip.weather_condition.max_temperature_f.between?(70, 79)}
      trips = trips.reduce({}) do |result, trip|
        result[trip.start_date] = 0 unless result[trip.start_date]
        result[trip.start_date] += 1
        result
      end
      expect(WeatherCondition.trips_on_days(conditions)).to eq(trips)
    end

  end

end