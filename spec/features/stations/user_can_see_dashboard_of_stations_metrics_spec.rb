require_relative '../../spec_helper'

describe 'When a user visists /stations-dashboard' do

  before do
    City.create(name: "Denver")
    City.create(name: "Fort Collins")
    @station1 = City.first.stations.create(name: "Denver Union Station", dock_count: 7, installation_date: "2013/12/02", lat: 37.330698, long: -121.888979)
    @station2 = City.last.stations.create(name: "Fort Collins Harmony", dock_count: 9, city_id: 2, installation_date: "2013/8/10", lat: 39.330698, long: -120.888979)
    visit('/station-dashboard')
  end

  describe "they can see" do
    it "an all stations heading" do
      within '.all-stations' do
        expect(page).to have_text "Station Dashboard"
      end
    end
  end

end
