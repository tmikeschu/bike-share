require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations'" do
  it "shows them an all stations heading" do
    visit('/stations')
    within 'h1' do
      expect(page).to have_text "All Stations"
    end
  end

  it "shows a station's information" do
    City.create(name: "Denver")
    City.first.stations.create(name: "Denver Union Station", dock_count: 7, installation_date: "12/2/2013")
    City.create(name: "Fort Collins")
    Station.create(name: "Fort Collins Harmony", dock_count: 9, city_id: 2, installation_date: "8/29/2013")
    visit('/stations')

    within 'div.station-summary > ul > li:nth-of-type(1)' do
      expect(page).to have_content "Denver Union Station"
    end

    within 'div.station-summary > ul > li:nth-of-type(2)' do
      expect(page).to have_content 7
    end

    within 'div.station-summary > ul > li:nth-of-type(3)' do
      expect(page).to have_content "Denver"
    end

    within 'div.station-summary > ul > li:nth-of-type(4)' do
      expect(page).to have_content "2013-02-12"
    end

    within 'div.station-summary > form:nth-of-type(1)' do
      expect(page).to have_button "Edit"
    end

    within 'div.station-summary > form:nth-of-type(2)' do
      expect(page).to have_button "Delete"
    end

  end

end