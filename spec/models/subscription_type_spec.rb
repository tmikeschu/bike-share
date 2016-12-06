require_relative '../spec_helper'

describe 'SubscriptionType' do

  describe 'validates' do
    it 'presence of subscription_type' do
      invalid_subscription_type = SubscriptionType.create(name: "")
      expect(invalid_subscription_type).to be_invalid
    end
  end

end
