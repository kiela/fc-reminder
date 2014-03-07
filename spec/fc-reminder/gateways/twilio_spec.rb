require 'spec_helper'

describe FCReminder::Gateways::Twilio do
  subject(:gateway) { FCReminder::Gateways::Twilio.new }
  let(:config) do
    {
      account_sid: "accound sid",
      auth_token: "auth token",
      phone_number: "+1234567890"
    }
  end

  context "#initialize" do
    it { expect(gateway).to be_kind_of(FCReminder::Gateways::Base) }
  end

  context "#client" do
    before { gateway.config = config }

    it { expect(gateway.client).to be_instance_of(Twilio::REST::Client) }
    it { expect{ gateway.client }.not_to change{ gateway.client } }
  end

  context "#send" do
    before { gateway.config = config }

    it { expect(gateway).to respond_to(:send).with(2).arguments }

    context "sends message via Twilio REST API" do
      before do
        allow_any_instance_of(Twilio::REST::Messages).to receive(:create)
      end

      it do
        expect(gateway.client.account.messages).to receive(:create).once
        gateway.send("recipient", {})
      end
    end
  end
end
