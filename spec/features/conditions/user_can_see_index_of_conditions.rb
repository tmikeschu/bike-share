require_relative '../../spec_helper'

describe 'When a user visists /conditions' do

  before do
    WeatherCondition.create(date: "2013-09-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    WeatherCondition.create(date: "2013-07-30", max_temperature_f: 80, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
    WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
    WeatherCondition.create(date: "1992-02-11", max_temperature_f: 80, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    @day1 = WeatherCondition.create(date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    visit('/conditions')
  end

  describe "they can see" do
    it "an all conditions heading" do
      within '.all-conditions' do
        expect(page).to have_text "All Weather Conditions"
      end
    end

    it "a condition's information" do
      within 'div.condition-summary:nth-of-type(1)' do
        expect(page).to have_content "Maximum Temperature (°F): 52"
        expect(page).to have_content "1991-01-02"
      end
    end

    it "new, edit, and delete buttons" do 
      expect(page).to have_button "Create New"
      within 'div.condition-summary:nth-of-type(1)' do
        expect(page).to have_button "Edit"
        expect(page).to have_button "Delete"
      end
    end

    it "and a different station's information" do
      within 'div.condition-summary:nth-of-type(2)' do
        expect(page).to have_content "Maximum Temperature (°F): 80"
        expect(page).to have_content "1992-02-11"
      end
    end
  end

  describe 'and when they click new' do
    it 'they are taken to the new page' do
      click_on "New"
      expect(current_path).to eq("/conditions/new")
    end
  end

  describe 'and when they click edit' do
    it 'they are taken to the edit page' do
      within 'div.condition-summary:nth-of-type(1)' do
        click_on "Edit"
        expect(current_path).to eq("/conditions/#{@day1.date}/edit")
      end
    end
  end

  describe 'and when they click delete' do
    it 'they are taken to the index page' do
      within 'div.condition-summary:nth-of-type(2)' do
        expect(page.body).to include("1992-02-11")
        click_on "Delete"
        expect(current_path).to eq("/conditions")
        expect(page.body).not_to include("1992-02-11")
      end
    end
  end

end