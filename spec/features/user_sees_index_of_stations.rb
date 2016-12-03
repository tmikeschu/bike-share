require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations'" do
  it "shows them an all stations heading" do
    visit('/stations')
    within 'h1' do
      expect(page).to have_text "All Stations"
    end
  end

  it "shows a station's name" do
    City.create(name: "Denver")
    City.create(name: "Fort Collins")
    Station.create(name: "Denver Union Station", dock_count: 7, city_id: 1, installation_date: "12/2/2013")
    Station.create(name: "Fort Collins Harmony", dock_count: 9, city_id: 2, installation_date: "12/1/2013")
    visit('/stations')
    # save_and_open_page

    within 'ul:nth-of-type(1) > li:nth-of-type(1)' do
      expect(page).to have_text "Denver Union Station"
    end

    within 'ul:nth-of-type(1) > li:nth-of-type(2)' do
      expect(page).to have_text "7"
    end

    within 'ul:nth-of-type(1) > li:nth-of-type(3)' do
      expect(page).to have_text "Denver"
    end

    within 'ul:nth-of-type(1) > li:nth-of-type(4)' do
      expect(page).to have_text "2013-02-12"
    end
    
  end

end