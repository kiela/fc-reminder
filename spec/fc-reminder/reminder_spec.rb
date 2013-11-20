require 'spec_helper'

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

    it "disallows to configure provider by using setter" do
      expect(reminder).not_to respond_to(:provider=)
    end

    it "disallows to configure gateway by using setter" do
      expect(reminder).not_to respond_to(:gateway=)
    end
  end

  context "#run" do
    subject(:reminder) { FCReminder.build }
    before(:each) { fake_page_with_match(reminder.provider.url) }
    before(:each) { reminder.gateway.stub(:send) {} }

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
      expect(reminder.provider).to receive(:run).with(team_name: team_name)

      reminder.team_name = team_name
      reminder.recipient = recipient
      reminder.run
    end

    it "calls gateway for sending message" do
      result = reminder.provider.run(team_name: team_name)
      expect(reminder.gateway).to receive(:send).with(
        recipient: recipient,
        data: result
      )

      reminder.team_name = team_name
      reminder.recipient = recipient
      reminder.run
    end
  end
end

