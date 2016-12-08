require_relative '../../spec_helper'

describe "when a user visits '/stations/1/edit'" do
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
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 4, bike_id: 501, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-07-30", start_station_id: 5, end_date: "2013-07-30", end_station_id: 1, bike_id: 50, subscription_type_id: 2, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2014-08-09", start_station_id: 4, end_date: "2014-08-10", end_station_id: 3, bike_id: 52, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "2013-01-02", start_station_id: 3, end_date: "2013-01-10", end_station_id: 5, bike_id: 20, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 100, start_date: "1992-02-11", start_station_id: 6, end_date: "1992-02-11", end_station_id: 6, bike_id: 131, subscription_type_id: 1, user_zip_code: 94127, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    WeatherCondition.create(date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.0, zip_code: 94107)
    WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    WeatherCondition.create(date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82, zip_code: 94107)
    WeatherCondition.create(date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1, zip_code: 94107)
    WeatherCondition.create(date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
    WeatherCondition.create(date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3, zip_code: 94107)
  end

  it "they see a create form" do
    visit '/stations/1/edit'
    expect(page).to have_content("Edit Station Information")
    expect(page).to have_field("station[name]")
    expect(page).to have_field("station[dock_count]")
    expect(page).to have_field("station[city_id]")
    expect(page).to have_field("station[lat]")
    expect(page).to have_field("station[long]")
    expect(page).to have_field("station[installation_date]")
    expect(page).to have_button("Edit")
  end

  it 'and they can see the existing station information in the form' do
    expect(find_field('station[name]').value).to eq("I Like Bike")
    expect(find_field('station[dock_count]').value).to eq("27")
    expect(find_field('station[city_id]').value).to eq("1")
    expect(find_field('station[lat]').value).to eq("37.330698")
    expect(find_field('station[long]').value).to eq("-121.888979")
    expect(find_field('station[installation_date]').value).to eq("2015-10-06 00:00:00 UTC")
  end

  it "they can edit station information" do
    station = Station.find_by(id: 1)
    
    visit '/stations/1/edit'
    fill_in 'station[name]', with: "TestStationOne"
    fill_in 'station[lat]', with: 36.330698
    fill_in 'station[long]', with: -120.888979
    find("option[value='2']").select_option
    fill_in 'station[dock_count]', with: 15
    fill_in 'station[installation_date]', with: "22/9/2016"
    click_on 'Edit'

    expect(current_path).to eq("/stations/#{station.id}")
    expect(page).to have_content("TestStationOne")
    expect(page).to have_content("2016-09-22")
    expect(page).to have_content(36.330698)
    expect(page).to have_content(-120.888979)
  end
end
