require_relative '../spec_helper'

describe 'City' do

  describe 'validates' do
    it 'presence of name' do
      invalid_station = City.first.stations.create(name: "")
      expect(invalid_station).to be_invalid
    end
  end

end
