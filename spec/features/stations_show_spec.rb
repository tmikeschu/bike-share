require_relative "../spec_helper"

describe "When a user wants to display data from a single station," do
    
  before do  
    @station = Station.create(name: "I Like Bike", city_id: 45, installation_date: 1501)
    @id = Station.find_by(name: "I Like Bike").id
    visit "/stations/#{@id}"
  end

  it "they see the station they expected," do
    expect(page).to have_content("I Like Bike")
  end

  it "the station's name," do
    expect(page).to have_content("I Like Bike")
  end

  it "and when it was established." do
    expect(page).to have_content(1501)
  end
end


