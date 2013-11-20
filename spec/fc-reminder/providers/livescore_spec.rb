require 'spec_helper'

describe FCReminder::Providers::LiveScore do
  subject(:provider) { FCReminder::Providers::LiveScore.new }
  let(:team_name) { "Barcelona" }

  context "#initialize" do
    it "should be instance of FCReminder::Providers::Base" do
      expect(provider).to be_kind_of(FCReminder::Providers::Base)
    end
  end

  context "#url" do
    it "returns valid url" do
      expect(provider.url).to match(/^#{URI::regexp}$/)
    end
  end

  context "#run" do
    context "there is no match that day" do
      before(:each) { fake_page_without_match(provider.url) }

      it "returns default value" do
        default_value = FCReminder::Providers::Base.new.run(team_name: team_name)
        expect(provider.run(team_name: team_name)).to eq(default_value)
      end
    end

    context "there is a match that day" do
      before(:each) { fake_page_with_match(provider.url) }

      it "returns non-empty instance of Hash" do
        expect(provider.run(team_name: team_name)).to be_an_instance_of(Hash)
        expect(provider.run(team_name: team_name)).not_to be_empty
      end

      %w(country league time team1 team2).each do |attr|
        it "has return value which includes #{attr}" do
          expect(provider.run(team_name: team_name)).to have_key(attr.to_sym)
        end
      end
    end
  end
end
