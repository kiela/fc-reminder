require 'spec_helper'

class TestProvider < FCReminder::Providers::Base
end

class TestGateway < FCReminder::Gateways::Base
end

describe FCReminder::Reminder do
  let(:team_name) { "Team Name" }
  let(:recipient) { "+1234567890" }

  describe "#initialize" do
    context "sets default values" do
      subject(:reminder) { FCReminder.build }

      it "sets #provider attribute" do
        expect(reminder.provider)
          .to be_instance_of(FCReminder::Providers::LiveScore)
      end
      it "sets #gatewaya attribute" do
        expect(reminder.gateway)
          .to be_instance_of(FCReminder::Gateways::Twilio)
      end
    end

    context "allows to configure attributes by using a block" do
      subject(:reminder) do
        team, receiver = team_name, recipient

        FCReminder.build do |config|
          config.provider = TestProvider.new
          config.gateway = TestGateway.new
          config.team_name = team
          config.recipient = receiver
        end
      end

    end
  end

  context "setters" do
    subject(:reminder) { FCReminder.build }

    context "provider" do
      it "disallows to set when instance doesn't inherit from FCReminder::Providers::Base" do
        expect{ reminder.provider = Object.new }.to raise_error
      end

      it "allows to set when instance inherits from FCReminder::Providers::Base" do
        obj = TestProvider.new
        expect(reminder.provider).not_to eq(obj)
        reminder.provider = obj
        expect(reminder.provider).to eq(obj)
      end
    end

    context "gateway" do
      it "disallows to set when instance doesn't inherit from FCReminder::Gateways::Base" do
        expect{ reminder.gateway = Object.new }.to raise_error
      end

      it "allows to set when instance inherits from FCReminder::Gateways::Base" do
        obj = TestGateway.new
        expect(reminder.gateway).not_to eq(obj)
        reminder.gateway = obj
        expect(reminder.gateway).to eq(obj)
      end
    end
  end

  describe "#run" do
    subject(:reminder) { FCReminder.build }

    it "accepts a block" do
      allow(reminder.provider).to receive(:run).and_return(Hash.new)
      allow(reminder.gateway).to receive(:send)

      prob = Proc.new{}
      expect(prob).to receive(:call)

      reminder.run(&prob)
    end

    it "calls provider for data" do
      allow(reminder.provider).to receive(:run).and_return(Hash.new)
      allow(reminder.gateway).to receive(:send)

      expect(reminder.provider).to receive(:run).with(team_name)

      reminder.team_name = team_name
      reminder.recipient = recipient
      reminder.run
    end

    it "calls gateway for sending message" do
      result = { foo: 'bar' }
      allow(reminder.provider).to receive(:run).and_return(result)
      allow(reminder.gateway).to receive(:send)

      expect(reminder.gateway).to receive(:send).with(recipient, result)

      reminder.team_name = team_name
      reminder.recipient = recipient
      reminder.run
    end
  end
end

