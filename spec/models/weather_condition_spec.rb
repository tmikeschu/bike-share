require_relative '../spec_helper'

#test presence of all data fields
#test zip_code = 90210 is invalid

describe 'WeatherCondition' do

  before do
    WeatherCondition.create(date: "2016/12/6",
                            max_temperature_f: "70",
                            mean_temperature_f: "50",
                            min_temperature_f: "40",
                            mean_humidity: "60",
                            mean_visibility_miles: "5",
                            mean_wind_speed_mph: "5",
                            precipitation_inches: "0.23",
                            zip_code: "94107")
  end

  describe 'validates' do
    it 'presence of station name' do
      invalid_station = City.first.stations.create(dock_count: 27, installation_date: "10/6/2015", lat: 37.329732, long: -121.90178200000001)
      expect(invalid_station).to be_invalid
    end
  end
  
end
