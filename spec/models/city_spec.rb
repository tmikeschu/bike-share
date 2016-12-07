require_relative '../spec_helper'

describe 'City' do

  describe 'validates' do
    it 'presence of name' do
      invalid_city = City.create(name: "")
      expect(invalid_city).to be_invalid
    end
  end

end
