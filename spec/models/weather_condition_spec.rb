require_relative '../spec_helper'

#test presence of all data fields
#test zip_code = 90210 is invalid
#test that WeatherCondition.first returns a WC
#test that WeatherCondition.first returns the WC we expect
#test that WeatherCondition.first.trips returns some trips
#test that WeatherCondition.first.trips returns the trips we expect



describe 'WeatherCondition' do

  before do
    WeatherCondition.create(date: "2016/12/6",
                            max_temperature_f: ,
                            mean_temperature_f: ,
                            min_temperature_f: ,
                            mean_humidity: ,
                            mean_visibility_miles: ,
                            mean_wind_speed_mph: ,
                            precipitation_inches: ,
                            zip_code: )
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
