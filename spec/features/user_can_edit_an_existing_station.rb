require_relative '../spec_helper'

describe "when a user visits '/stations/:id/new'" do
  it "they can edit station information" do
    visit 'stations/:id/new'

    fill_in 'station[name]', with: "TestStationOne"
    fill_in 'station[dock_count]', with: 15
    fill_in 'station[city_id]', with: 3
    fill_in 'station[installation_date]', with: "9/22/2016"

    click_on 'Submit'

    station = Station.find_by(id: 1)
    expect(current_path).to eq("directors/#{station.id}")
    expect(page).to have_content("TestStationOne")
    expect(page).to have_content("9/22/2016")
  end
end
