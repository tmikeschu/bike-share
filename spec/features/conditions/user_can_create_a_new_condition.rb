require_relative '../../spec_helper'

describe "When a user visits the new condition path" do
  before do
    WeatherCondition.create(date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
    WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
    WeatherCondition.create(date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    WeatherCondition.create(date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
  end

  it "they see a create form" do
    visit '/conditions/new'
    expect(page).to have_content("Add Weather Information")
    expect(page).to have_field("condition[date]")
    expect(page).to have_field("condition[max_temperature_f]")
    expect(page).to have_field("condition[min_temperature_f]")
    expect(page).to have_field("condition[mean_temperature_f]")
    expect(page).to have_field("condition[mean_humidity]")
    expect(page).to have_field("condition[mean_visibility_miles]")
    expect(page).to have_field("condition[mean_wind_speed_mph]")
    expect(page).to have_field("condition[precipitation_inches]")
    expect(page).to have_button("Create")
  end

  it "they can create a new condition" do
    visit '/conditions/new'
    fill_in "condition[date]", with: "2016/12/07"
    fill_in "condition[max_temperature_f]", with: 17
    fill_in "condition[min_temperature_f]", with: 1
    fill_in "condition[mean_temperature_f]", with: 1
    fill_in "condition[mean_humidity]", with: -1
    fill_in "condition[mean_visibility_miles]", with: 1
    fill_in "condition[mean_wind_speed_mph]", with: 1
    fill_in "condition[precipitation_inches]", with: 1
    click_on 'Create'
    new_station = WeatherCondition.find_by(date: "2016/12/07")
    expect(current_path).to eq("/conditions")
    expect(page).to have_content("17")
    expect(page).to have_content("-1")
    expect(page).to have_content("2016-12-07")
  end

end
