require_relative "../spec_helper"

describe "When a user wants to display data from a single station," do
    
  before do  
    City.create(name: "Denver")
    City.first.stations.create(name: "I Like Bike", dock_count: 27, installation_date: "10/6/2015", lat: 37.330698, long: -121.888979)
    visit "/stations/#{Station.first.id}"
  end

  it "they see the station they expected," do
    expect(page).to have_content("I Like Bike")
  end

  it "they see the station's city," do
    expect(page).to have_content("Denver")
  end

  it "they see the proper dock count," do
    expect(page).to have_content(27)
  end

  it "they see the latitude and longitude," do
    expect(page).to have_content(37.330698)
    expect(page).to have_content(-121.888979)
  end

  it "and when it was established." do
    expect(page).to have_content("2015")
  end
end


