require_relative '../../spec_helper'

describe 'When a user visists /trips-dashboard' do

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

    SubscriptionType.last.trips.create(duration: 1148,
                                        start_date: "2016/12/6",
                                        start_station_id: 1,
                                        end_date: "2016/12/6",
                                        end_station_id: 2,
                                        bike_id: 9090909089,
                                        subscription_type_id: 2,
                                        user_zip_code: 90211,
                                        start_time: "14:13:01 UTC",
                                        end_time: "14:20:01 UTC")
    visit('/trips')
  end

  describe "they can see" do
    it "an all trips heading" do
      within '.all-trips' do
        expect(page).to have_text "All Trips"
      end
    end

    it "a trip's information" do
      expect(page).to have_button "New"
      within 'div.trips-summary:nth-of-type(1)' do
        expect(page).to have_content "Denver Union Station"
        expect(page).to have_content 7
        expect(page).to have_content "Denver"
        expect(page).to have_content 37.330698
        expect(page).to have_content -121.888979
        expect(page).to have_content "2013-12-02"
      end
    end

    it "new, edit, and delete buttons" do
      expect(page).to have_button "New"
      within 'div.trips-summary:nth-of-type(1)' do
        expect(page).to have_button "Edit"
        expect(page).to have_button "Delete"
      end
    end

    it "and a different trip's information" do
      within 'div.trips-summary:nth-of-type(2)' do
        expect(page).to have_content "Fort Collins Harmony"
        expect(page).to have_content 9
        expect(page).to have_content "Fort Collins"
        expect(page).to have_content 39.330698
        expect(page).to have_content -120.888979
        expect(page).to have_content "2013-08-10"
      end
    end
  end

  describe 'and when they click new' do
    it 'they are taken to the new page' do
      click_on "New"
      expect(current_path).to eq("/trips/new")
    end
  end

  describe 'and when they click edit' do
    it 'they are taken to the edit page' do
      within 'div.trips-summary:nth-of-type(1)' do
        click_on "Edit"
        expect(current_path).to eq("/trips/#{@trip1.id}/edit")
      end
    end
  end

  describe 'and when they click delete' do
    it 'they are taken to the index page' do
      within 'div.trips-summary:nth-of-type(2)' do
        expect(page.body).to include("Fort Collins")
        click_on "Delete"
        expect(current_path).to eq("/stations")
        expect(page.body).not_to include("Fort Collins")
      end
    end
  end

end
