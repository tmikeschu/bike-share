require_relative '../spec_helper'


describe 'WeatherCondition' do

  describe 'validates' do

    it 'presence of date' do
      invalid_wc = WeatherCondition.create( date: "",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of max_temperature_f' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of mean_temperature_f' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of min_temperature_f' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of mean_humidity' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of mean_visibility_miles' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of mean_wind_speed_mph' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "",
                                            precipitation_inches: "0.23",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of precipitation_inches' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "",
                                            zip_code: "94107")

      expect(invalid_wc).to be_invalid
    end

    it 'presence of zip_code' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "")

      expect(invalid_wc).to be_invalid
    end

    it 'zip_code is 94107' do
      invalid_wc = WeatherCondition.create( date: "2016/12/6",
                                            max_temperature_f: "70",
                                            mean_temperature_f: "50",
                                            min_temperature_f: "40",
                                            mean_humidity: "60",
                                            mean_visibility_miles: "5",
                                            mean_wind_speed_mph: "5",
                                            precipitation_inches: "0.23",
                                            zip_code: "90210")

      expect(invalid_wc).to be_invalid
    end

  end

end
