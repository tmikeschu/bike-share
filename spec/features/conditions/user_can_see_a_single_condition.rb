require_relative "../../spec_helper"

describe "When a user wants to display data from a single condition," do
    
  before do  
    @day1 = WeatherCondition.create(date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, mean_humidity: 75, mean_visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4, zip_code: 94107)
    visit "/conditions/#{WeatherCondition.first.id}"
  end

  it "they see the condition's information," do
    expect(page).to have_content("2013-07-30")
    expect(page).to have_content(84)
    expect(page).to have_content(68)
    expect(page).to have_content(61)
    expect(page).to have_content(75)
    expect(page).to have_content(2)
    expect(page).to have_content("Precipitation (Inches): 0.4")
  end

  describe 'when they click edit' do
    it 'they are taken to the edit page' do
      click_on "Edit"
      expect(current_path).to eq("/conditions/#{@day1.id}/edit")
    end
  end

  describe 'when they click delete' do
    it 'they are taken to the index page' do
      expect(page.body).to include("2013-07-30")
      click_on "Delete"
      expect(current_path).to eq("/conditions")
      expect(page.body).not_to include("2013-07-30")
    end
  end
end


