require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations'" do
  City.create(name: "Denver")
  Station.create(name: "Denver", dock_count: 7, city_id: 1, installation_date: "12/2/2013")
  it "shows them an all stations heading" do
    visit('/stations')
    within 'h1' do
      expect(page).to have_text "All Stations"
    end
  end

  it "shows a station's name" do
    visit('/stations')
    within 'h1 nth-of-type(1)' do
      expect(page).to have_text  
    end
  end

end