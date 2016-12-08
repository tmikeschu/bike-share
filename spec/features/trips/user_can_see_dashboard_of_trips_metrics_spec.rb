require_relative '../../spec_helper'

describe 'When a user visists /trip-dashboard' do

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
    visit('/trip-dashboard')
  end

  describe "they can see" do
    it "an all trips heading" do
      within '.all-trips' do
        expect(page).to have_text "Trips Dashboard"
      end
    end

  end



end
