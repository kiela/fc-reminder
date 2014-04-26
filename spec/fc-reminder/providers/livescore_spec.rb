require 'spec_helper'

describe FCReminder::Providers::LiveScore do
  subject(:provider) { FCReminder::Providers::LiveScore.new }
  let(:team_name) { "Barcelona" }

  describe "#initialize" do
    it { expect(provider).to be_kind_of(FCReminder::Providers::Base) }
  end

  describe "#url" do
    it "should be valid" do
      expect(provider.url).to match(/^#{URI::regexp}$/)
    end
  end

  describe "#run" do
    context "when there is no match that day" do
      before { fake_page_without_match(provider.url) }
      subject(:results) { provider.run(team_name) }

      it { expect(results).to be_empty }
    end

    context "when there is a match that day" do
      before { fake_page_with_match(provider.url) }
      subject(:results) { provider.run(team_name) }

      it "returns the match details" do
        details = {
          :country => "Spain",
          :league => "Liga BBVA",
          :time => "21:00",
          :team1 => "Athletic Bilbao",
          :team2 => "Barcelona"
        }

        expect(results).to eq(details)
      end
    end
  end
end
