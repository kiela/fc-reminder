require 'spec_helper'

describe FCReminder::Gateways::Twilio do
  subject(:gateway) { FCReminder::Gateways::Twilio.new }

  context "#initialize" do
    it "should be instance of FCReminder::Gateways::Base" do
      expect(gateway).to be_kind_of(FCReminder::Gateways::Base)
    end
  end
end
