require_relative '../spec_helper'

describe "When a user visits the new station path" do
  it "they can create a new station" do
    City.create(name: "Denver")
    City.create(name: "Aurora")
    
    visit '/stations/new'

    fill_in 'station[name]', with: "Station Name1"
    find("option[value='1']").click
    fill_in 'station[dock_count]', with: "27"
    fill_in 'station[installation_date]', with: "8/7/2013"
    click_on 'Create Station'

    new_station = Station.find_by(name: "Station Name1")
    expect(current_path).to eq("/stations/#{new_station.id}")
    expect(page).to have_content("Station Name1")
  end

end
