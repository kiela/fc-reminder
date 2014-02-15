require 'spec_helper'

class TestProvider < FCReminder::Providers::Base
end

class TestGateway < FCReminder::Gateways::Base
end

describe FCReminder::Reminder do
  let(:team_name) { "Team Name" }
  let(:recipient) { "+1234567890" }

  context "#initialize" do
    it "sets default values" do
      reminder = FCReminder.build
      expect(reminder.provider).to be_kind_of(FCReminder::Providers::Base)
      expect(reminder.gateway).to be_kind_of(FCReminder::Gateways::Base)
    end

    it "allows to configure attributes by using a block" do
      team, receiver = team_name, recipient

      reminder = FCReminder.build do |config|
        config.team_name = team
        config.recipient = receiver
      end

      expect(reminder.team_name).to eq(team)
      expect(reminder.recipient).to eq(receiver)
    end
  end

  context "setters" do
    subject(:reminder) { FCReminder.build }

    it "allows to set team_name attribute" do
      expect(reminder.team_name).to be_nil
      reminder.team_name = team_name
      expect(reminder.team_name).to eq(team_name)
    end

    it "allows to set recipient attribute" do
      expect(reminder.recipient).to be_nil
      reminder.recipient = recipient
      expect(reminder.recipient).to eq(recipient)
    end

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

  context "#run" do
    subject(:reminder) { FCReminder.build }
    before(:each) { fake_page_with_match(reminder.provider.url) }
    before(:each) { allow(reminder.gateway).to receive(:send) }

    it "allows to set consumer data by using a block" do
      expect(reminder.team_name).to be_nil
      expect(reminder.recipient).to be_nil

      team, receiver = team_name, recipient
      reminder.run do |config|
        config.team_name = team
        config.recipient = receiver
      end

      expect(reminder.team_name).to eq(team)
      expect(reminder.recipient).to eq(receiver)
    end

    it "calls provider for data" do
      allow(reminder.provider).to receive(:run).and_return(Hash.new)
      expect(reminder.provider).to receive(:run).with(team_name)

      reminder.team_name = team_name
      reminder.recipient = recipient
      reminder.run
    end

    it "calls gateway for sending message" do
      result = {foo: 'bar'}
      allow(reminder.provider).to receive(:run).and_return(result)
      expect(reminder.gateway).to receive(:send).with(recipient, result)

      reminder.team_name = team_name
      reminder.recipient = recipient
      reminder.run
    end
  end
end

