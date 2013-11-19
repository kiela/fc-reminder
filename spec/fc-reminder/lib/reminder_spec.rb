require 'spec_helper'

describe FCReminder::Reminder do
  let(:team_name) { "Team Name" }

  context "#initialize" do
    it "sets default values" do
      reminder = FCReminder.build
      expect(reminder.provider).to be_kind_of(FCReminder::Providers::Base)
    end

    it "allows to configure reminder by using a block" do
      team = team_name
      reminder = FCReminder.build { |config| config.team_name = team }
      expect(reminder.team_name).to eq(team)
    end
  end

  context "setters" do
    subject(:reminder) { FCReminder.build }

    it "allows to configure reminder by using setters" do
      reminder.team_name = team_name
      expect(reminder.team_name).to eq(team_name)
    end

    it "disallows to configure provider by using setter" do
      expect(reminder).not_to respond_to(:provider=)
    end
  end

  context "#run" do
    subject(:reminder) { FCReminder.build }
    before(:each) { fake_page_with_match(reminder.provider.url) }

    it "allows to set consumer data by using a block" do
      team = team_name
      reminder.run { |config| config.team_name = team }
      expect(reminder.team_name).to eq(team)
    end

    it "calls provider for data" do
      expect(reminder.provider).to receive(:run).with(team_name: team_name)
      reminder.team_name = team_name
      reminder.run
    end
  end
end
