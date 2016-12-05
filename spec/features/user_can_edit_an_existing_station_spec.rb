require_relative '../spec_helper'

describe "when a user visits '/stations/1/edit'" do
  before do
    City.create(name: "Denver")
    City.create(name: "Aurora")
    City.first.stations.create(name: "I Like Bike", dock_count: 27, installation_date: "10/6/2015", lat: 37.330698, long: -121.888979)
    # require 'pry'; binding.pry    
  end

  it "they see a create form" do
    visit '/stations/1/edit'
    save_and_open_page
    expect(page).to have_content("Edit Station Information")
    expect(page).to have_field("station[name]")
    expect(page).to have_field("station[dock_count]")
    expect(page).to have_field("station[city_id]")
    expect(page).to have_field("station[lat]")
    expect(page).to have_field("station[long]")
    expect(page).to have_field("station[installation_date]")
    expect(page).to have_button("Create Station")
  end

  # it 'they can see the existing station information in the form' do

  # end

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
