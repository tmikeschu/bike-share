require_relative '../spec_helper'

describe 'Trip Model' do
  before do
    %w(Denver Aurora Centennial).each {|city| City.create(name: city) }
    %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
    station1 = City.first.stations.create(  name: "Union",
                                            dock_count: 27,
                                            installation_date: "10/6/2015",
                                            lat: 37.329732,
                                            long: -121.90178200000001)
    station2 = City.first.stations.create(  name: "Denver",
                                            dock_count: 27,
                                            installation_date: "10/6/2015",
                                            lat: 27.329732,
                                            long: -111.90178200000001)
    subscription = SubscriptionType.create(subscription_type: "Subscriber")
    denver, aurora, centennial = City.find(1), City.find(2), City.find(3)
    denver.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    denver.stations.create(name: "San Jose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    aurora.stations.create(name: "Jan Sose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    aurora.stations.create(name: "Jan Sose Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    centennial.stations.create(name: "Naj Esos Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    centennial.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    Trip.create(duration: 1000, start_date: "2013-08-29", start_station_id: 1, end_date: "2013-08-29", end_station_id: 2, bike_id: 520, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 5, bike_id: 501, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 187, start_date: "2013-07-30", start_station_id: 5, end_date: "2013-07-30", end_station_id: 1, bike_id: 50, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 203, start_date: "2014-08-09", start_station_id: 3, end_date: "2014-08-10", end_station_id: 3, bike_id: 52, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-01-02", start_station_id: 3, end_date: "2013-01-10", end_station_id: 5, bike_id: 20, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 680, start_date: "1992-02-11", start_station_id: 6, end_date: "1992-02-11", end_station_id: 6, bike_id: 50, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    WeatherCondition.create(date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
    WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
    WeatherCondition.create(date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    WeatherCondition.create(date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
  end

  describe 'validates' do
    it 'presence of duration' do
      invalid_trip = SubscriptionType.first.trips.create(
                                  duration: "",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of start_date' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of start_station_id' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of end_date' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of end_station_id' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of bike_id' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of SubscriptionType.first_type_id' do
      invalid_trip = Trip.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of user_zip_code' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of start_time' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'presence of end_time' do
      invalid_trip = SubscriptionType.first.trips.create( duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02"
                                  )
      expect(invalid_trip).to be_invalid
    end

    it 'uniqueness of bike_id and start_time' do
      SubscriptionType.first.trips.create(
                                  duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      invalid_trip = SubscriptionType.first.trips.create(
                                  duration: "1147",
                                  start_date: "2016/12/5",
                                  start_station_id: "1",
                                  end_date: "2016/12/6",
                                  end_station_id: "2",
                                  bike_id: "1",
                                  user_zip_code: "90210",
                                  start_time: "22:53:02",
                                  end_time: "22:53:08"
                                  )
      expect(invalid_trip).to be_invalid
    end
  end

  describe 'associations' do
    before do
      @trip = Trip.first
    end

    it "#start_station returns start station" do
      station = @trip.start_station
      expect(@trip.start_station.class.to_s).to eq("Station")
      expect(station.departure_trips.include?(@trip)).to be true
    end
    
    it "#end_station returns end station" do
      station = @trip.end_station
      expect(@trip.end_station.class.to_s).to eq("Station")
      expect(station.arrival_trips.include?(@trip)).to be true
    end
    
    it "#subscription_type returns subscription type" do
      sub_type = @trip.subscription_type
      expect(sub_type.class.to_s).to eq("SubscriptionType")
      expect(sub_type.trips.include?(@trip)).to be true
    end
    
    it "#weather_condition returns conditions for trip" do
      condition = @trip.weather_condition
      expect(condition.class.to_s).to eq("WeatherCondition")
      expect(condition.trips.include?(@trip)).to be true
    end
  end

  describe 'analytics' do
    it ".average_trip_duration returns average" do
      expect(Trip.average_trip_duration).to eq(6)
    end
    
    it ".maximum_trip_duration returns trip time max minutes" do
      expect(Trip.maximum_trip_duration).to eq(16)
    end
    
    it ".minimum_trip_duration returns trip time min minutes" do
      expect(Trip.minimum_trip_duration).to eq(1)
    end
    
    it ".station_with_most_rides_as_start_point returns station and count" do
      station = Trip.station_with_most_rides_as_start_point
      expect(station.class).to eq(Array)
      expect(station.first.class.to_s).to eq("Station")
      expect(station.first.name).to eq("San Jose Diridon Caltrain Station")
      expect(station.last.class).to eq(Fixnum)
    end
    
    it ".station_with_most_rides_as_end_point returns station and count" do
      station = Trip.station_with_most_rides_as_end_point
      expect(station.class).to eq(Array)
      expect(station.first.class.to_s).to eq("Station")
      expect(station.first.name).to eq("Jan Sose Diridon Caltrain Station")
      expect(station.last.class).to eq(Fixnum)
    end
    
    it ".most_ridden_bike_and_ride_count returns bike and count" do
      bike = Trip.most_ridden_bike_and_ride_count
      expect(bike.class).to eq(Array)
      expect(bike.first.class).to eq(Fixnum)
      expect(bike.first).to eq(50)
      expect(bike.last.class).to eq(Fixnum)
    end
    
    it ".least_ridden_bike_and_ride_count returns bike and count" do
      bike = Trip.least_ridden_bike_and_ride_count
      expect(bike.class).to eq(Array)
      expect(bike.first.class).to eq(Fixnum)
      expect(bike.first).to eq(20)
      expect(bike.last.class).to eq(Fixnum)
    end
    
    it ".subscription_breakdown returns hash of types and counts" do
      breakdown = Trip.subscription_breakdown
      expect(breakdown.class).to eq(Hash)
      expect(breakdown).to have_key(1)
      expect(breakdown).to have_key(2)
    end
    
    it ".subscriber_breakdown returns hash of types and counts" do
      breakdown = Trip.subscriber_breakdown
      expect(breakdown.class).to eq(Fixnum)
    end

    it ".subscriber_percentage returns hash of types and counts" do
      percentage = Trip.subscriber_percentage
      expect(percentage.class).to eq(Fixnum)
    end

    it ".subscriber_metrics returns hash of types and counts" do
      metrics = Trip.subscriber_metrics
      expect(metrics.class).to eq(Hash)
      expect(metrics).to have_key(:count)
      expect(metrics).to have_key(:percentage)
    end
    
    it ".customer_breakdown returns hash of types and counts" do
      breakdown = Trip.customer_breakdown
      expect(breakdown.class).to eq(Fixnum)
    end
    
    it ".customer_percentage returns hash of types and counts" do
      percentage = Trip.customer_percentage
      expect(percentage.class).to eq(Fixnum)
    end

    it ".customer_metrics returns hash of types and counts" do
      metrics = Trip.customer_metrics
      expect(metrics.class).to eq(Hash)
      expect(metrics).to have_key(:count)
      expect(metrics).to have_key(:percentage)
    end

    it ".subscription_metrics returns nested hash of metrics" do
      metrics = Trip.subscription_metrics
      expect(metrics.class).to eq(Hash)
      expect(metrics.values.all?{|val| val.class == Hash}).to be true
      expect(metrics.values.all?{|val| val.has_key?(:count) && val.has_key?(:percentage)}).to be true
    end

    it ".date_with_highest_number_trips_total returns date and count" do
      date_trips = Trip.date_with_highest_number_trips_total
      expect(date_trips.class).to eq(Array)
      expect(date_trips.first.class).to eq(Date)
      expect(date_trips.last).to eq(2)
    end

    it ".date_with_lowest_number_trips_total returns date and count" do
      date_trips = Trip.date_with_lowest_number_trips_total
      expect(date_trips.class).to eq(Array)
      expect(date_trips.first.class).to eq(Date)
      expect(date_trips.last).to eq(1)
    end
    
    it ".month_by_month_breakdown_for_year returns hash of months pointing to trip count" do
      breakdown = Trip.month_by_month_breakdown_for_year(2013)
      expect(breakdown.class).to eq(Hash)
      expect(breakdown.keys.first.class).to eq Time
    end
    
    it ".add_total adds total key to hash" do
      hash = {a: 1, b: 9}
      hash = Trip.add_total(hash)
      expect(hash).to eq({a: 1, b: 9, total: 10})
    end
    
    it ".monthly_breakdown_master returns hash of years pointing to months to trip count and total" do
      breakdown = Trip.monthly_breakdown_master
      expect(breakdown.class).to eq(Hash)
      expect(breakdown).to have_key(2013)
      expect(breakdown).to have_key(1992)
      expect(breakdown).to have_key(2014)
    end
    
  end

end
