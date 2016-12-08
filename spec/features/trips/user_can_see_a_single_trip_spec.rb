require_relative "../../spec_helper"

describe "When a user wants to display data from a single trip," do

  before do
    %w(Denver Centennial).each {|city| City.create(name: city) }
    %w(Subscriber Customer).each {|type| SubscriptionType.create(subscription_type: type) }
    City.first.stations.create(name: "San Jose Diridon Caltrain Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", lat: 37.329732, long: -121.901782)
    City.last.stations.create(name: "Naj Esos Civic Center", dock_count: 15, installation_date: "2013-08-05 00:00:00", lat: 37.330698, long: -121.888979)
    @trip1 = SubscriptionType.first.trips.create(duration: 1147,
                                        start_date: "2016/12/7",
                                        start_station_id: 1,
                                        end_date: "2016/12/7",
                                        end_station_id: 2,
                                        bike_id: 9090909090,
                                        subscription_type_id: 1,
                                        user_zip_code: 90210,
                                        start_time: "14:13:00 UTC",
                                        end_time: "14:20:00 UTC")
    visit "/trips/#{Trip.first.id}"
  end

  it "they see the trip's information," do
    expect(page).to have_content("1147")
    expect(page).to have_content("2016-12-07")
    expect(page).to have_content("San Jose Diridon Caltrain Station")
    expect(page).to have_content("2016-12-07")
    expect(page).to have_content("Naj Esos Civic Center")
    expect(page).to have_content("9090909090")
    expect(page).to have_content("Subscriber")
    expect(page).to have_content("14:13:00 UTC")
    expect(page).to have_content("14:20:00 UTC")
  end

  describe 'when they click edit' do
    it 'they are taken to the edit page' do
      click_on "Edit"
      expect(current_path).to eq("/trips/#{@trip1.id}/edit")
    end
  end

  describe 'when they click delete' do
    it 'they are taken to the index page' do
      expect(page).to have_content("1147")
      click_on "Delete"
      expect(current_path).to eq("/trips")
      expect(page).not_to have_content("1147")
    end
  end
end
