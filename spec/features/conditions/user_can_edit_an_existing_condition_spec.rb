require_relative '../../spec_helper'

describe "when a user visits '/conditions/(date)/edit'" do
  before do
    WeatherCondition.create(date: "2013-09-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    visit '/conditions/2013-09-30/edit'
  end

  it "they see a create form" do
    expect(page).to have_content("Edit Weather Information")
    expect(page).to have_field("condition[date]")
    expect(page).to have_field("condition[max_temperature_f]")
    expect(page).to have_field("condition[min_temperature_f]")
    expect(page).to have_field("condition[mean_temperature_f]")
    expect(page).to have_field("condition[mean_humidity]")
    expect(page).to have_field("condition[mean_visibility_miles]")
    expect(page).to have_field("condition[mean_wind_speed_mph]")
    expect(page).to have_field("condition[precipitation_inches]")
    expect(page).to have_button("Edit")
  end

  it 'and they can see the existing condition information in the form' do
    expect(find_field("condition[date]").value).to eq("2013-09-30")
    expect(find_field("condition[max_temperature_f]").value).to eq("84")
    expect(find_field("condition[min_temperature_f]").value).to eq("61")
    expect(find_field("condition[mean_temperature_f]").value).to eq("68")
    expect(find_field("condition[mean_humidity]").value).to eq("75")
    expect(find_field("condition[mean_visibility_miles]").value).to eq("15")
    expect(find_field("condition[mean_wind_speed_mph]").value).to eq("3")
    expect(find_field("condition[precipitation_inches]").value).to eq("0.4")
  end

  it "they can edit condition information" do
    condition = WeatherCondition.first
    # fill_in "condition[date]", with: "2016/12/07"
    fill_in "condition[max_temperature_f]", with: 17
    fill_in "condition[min_temperature_f]", with: 1
    fill_in "condition[mean_temperature_f]", with: 1
    fill_in "condition[mean_humidity]", with: -1
    fill_in "condition[mean_visibility_miles]", with: 1
    fill_in "condition[mean_wind_speed_mph]", with: 1
    fill_in "condition[precipitation_inches]", with: 1
    click_on 'Edit'
    condition = WeatherCondition.first
    expect(current_path).to eq("/conditions/#{condition.date}")
    expect(page).to have_content("17")
    expect(page).to have_content("-1")
    expect(page).to_not have_content("84")
  end
end
