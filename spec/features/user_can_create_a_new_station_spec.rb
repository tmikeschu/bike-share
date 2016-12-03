require_relative '../spec_helper'

describe "When a user visits the new station path" do
  it "they can create a new station" do
    visit '/stations/new'

    fill_in 'station[name]', with: "Station Name1"
    fill_in 'station[lat]', with: "37.329732"
    fill_in 'station[long]', with: "-121.894074"
    fill_in 'station[city_id]', with: "1"
    fill_in 'station[dock_count]', with: "27"
    fill_in 'station[installation_date]', with: "8/7/2013"
    click_on 'submit'

    new_station = Station.find_by(name: "Station Name1")
    expect(current_path).to eq("/stations/#{new_station.id}")
    expect(page).to have_content("Station Name1")
  end

  #need to validate attributes

end
