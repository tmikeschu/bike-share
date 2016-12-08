require_relative '../../spec_helper'

describe "when a user visits '/trips/1/edit'" do
  before do
    %w(Denver Centennial).each {|city| City.create(name: city) }
    %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
    City.first.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    City.last.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    SubscriptionType.first.trips.create(duration: 1147,
                                        start_date: "2016/12/7",
                                        start_station_id: 1,
                                        end_date: "2016/12/7",
                                        end_station_id: 2,
                                        bike_id: 9090909090,
                                        subscription_type_id: 1,
                                        user_zip_code: 90210,
                                        start_time: "14:13:00 UTC",
                                        end_time: "14:20:00 UTC")
  end

  it "they see an edit form" do
    visit '/trips/1/edit'
    expect(page).to have_content("Edit Trip Information")
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
    expect(page).to have_button("Edit")
  end

  it 'and they can see the existing trip information in the form' do
    expect(find_field('trip[duration]').value).to eq("1147")
    expect(find_field('trip[start_date]').value).to eq("2016-12-07")
    expect(find_field('trip[start_station_id]').value).to eq("1")
    expect(find_field('trip[end_date]').value).to eq("2016-12-07")
    expect(find_field('trip[end_station_id]').value).to eq("2")
    expect(find_field('trip[bike_id]').value).to eq("9090909090")
    expect(find_field('trip[subscription_type_id]').value).to eq("1")
    expect(find_field('trip[user_zip_code]').value).to eq("90210")
    expect(find_field('trip[start_time]').value).to eq("14:13:00 UTC")
    expect(find_field('trip[end_time]').value).to eq("14:20:00 UTC")
  end

  it "they can edit trip information" do
    trip = Trip.find(1)

    visit '/trips/1/edit'
    fill_in 'trip[duration]', with: "1146"
    fill_in 'trip[start_date]', with: "2016/12/6"
    within '.dropdownclass:nth-of-type(1)' do
      find("option[value='1']").select_option
    end
    fill_in 'trip[end_date]', with: "2016/12/6"
    within '.dropdownclass:nth-of-type(2)' do
      find("option[value='1']").select_option
    end
    fill_in 'trip[bike_id]', with: "9090909089"
    within '.dropdownclass:nth-of-type(1)' do
      find("option[value='2']").select_option
    end
    fill_in 'trip[start_time]', with: "14:13:01 UTC"
    fill_in 'trip[end_time]', with: "14:20:01 UTC"
    click_on 'Edit'

    expect(current_path).to eq("/trips/#{trip.id}")
    expect(page).to have_content("1146")
    expect(page).to have_content("2016-12-06")
    expect(page).to have_content("San Jose Diridon Caltrain Station")
    expect(page).to have_content("2016-12-06")
    expect(page).to_not have_content("Naj Esos Civic Center")
    expect(page).to have_content("9090909089")
    expect(page).to have_content("Customer")
    expect(page).to have_content("14:13:01 UTC")
    expect(page).to have_content("14:20:01 UTC")
  end
end
