require_relative '../../spec_helper'

describe 'When a user visists /weather-dashboard' do

  before do
    WeatherCondition.create(date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
    WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
    WeatherCondition.create(date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    WeatherCondition.create(date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    visit('/weather-dashboard')
  end
    

  describe "they can see" do
    it "a temperature breakdown" do
      expect(page).to have_text "Temperature Breakdown"
      expect(page).to have_text "High Temperature"
      expect(page).to have_text "Average Rides"
      expect(page).to have_text "Highest Rides"
      expect(page).to have_text "Least Rides"
    end
    
    it "a precipitation breakdown" do
      expect(page).to have_text "Precipitation Breakdown"
      expect(page).to have_text "(inches)"
      expect(page).to have_text "Average Rides"
      expect(page).to have_text "Highest Rides"
      expect(page).to have_text "Least Rides"
    end
    
    it "a temperature breakdown" do
      expect(page).to have_text "Wind Speed Breakdown"
      expect(page).to have_text "(mph)"
      expect(page).to have_text "Average Rides"
      expect(page).to have_text "Highest Rides"
      expect(page).to have_text "Least Rides"
    end
    
    it "a temperature breakdown" do
      expect(page).to have_text "Visibility Breakdown"
      expect(page).to have_text "(miles)"
      expect(page).to have_text "Average Rides"
      expect(page).to have_text "Highest Rides"
      expect(page).to have_text "Least Rides"
    end

  end

end