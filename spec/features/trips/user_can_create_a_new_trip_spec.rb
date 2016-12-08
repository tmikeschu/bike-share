require_relative '../../spec_helper'

describe "When a user visits the new trip path" do
  before do
    %w(Denver Centennial).each {|city| City.create(name: city) }
    %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
    City.first.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    City.last.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
  end

  it "they see a create form" do
    visit '/trips/new'
    expect(page).to have_content("Create a New Trip")
    expect(page).to have_field("trip[duration]")
    expect(page).to have_field("trip[start_date]")
    expect(page).to have_field("trip[start_station_id]")
    expect(page).to have_field("trip[end_date]")
    expect(page).to have_field("trip[end_station_id]")
    expect(page).to have_field("trip[bike_id]")
    expect(page).to have_field("trip[subscription_type_id]")
    expect(page).to have_field("trip[user_zip_code]")
    expect(page).to have_field("trip[start_time]")
    expect(page).to have_field("trip[end_time]")

    expect(page).to have_button("Create")
  end

  it "they can create a new trip" do
    visit '/trips/new'
    fill_in 'trip[duration]', with: "1147"
    fill_in 'trip[start_date]', with: "2016/12/7"
    within '.dropdown:nth-of-type(1)' do
      find("option[value='1']").select_option
    end
    fill_in 'trip[end_date]', with: "2016/12/7"
    within '.dropdown:nth-of-type(1)' do
      find("option[value='1']").select_option
    end
    fill_in 'trip[bike_id]', with: "9090909090"
    within '.dropdown:nth-of-type(1)' do
      find("option[value='1']").select_option
    end
    fill_in 'trip[start_time]', with: "14:13:00 UTC"
    fill_in 'trip[end_time]', with: "14:20:00 UTC"

    click_on 'Create'

    expect(current_path).to eq("/trips")
    expect(page).to have_content("1147")
    expect(page).to have_content("2016-12-07")
    expect(page).to have_content("Naj Esos Civic Center")
    expect(page).to have_content("San Jose Diridon Caltrain Station")
    expect(page).to have_content("2016/12/7")
    expect(page).to have_content("9090909090")
    expect(page).to have_content("Subscriber")
    expect(page).to have_content("14:13:00 UTC")
    expect(page).to have_content("14:20:00 UTC")
  end

end
