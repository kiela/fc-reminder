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
    it "returns empty results when there is no match that day" do
      fake_page_without_match(provider.url)
      results = provider.run(team_name)

      expect(results).to be_empty
    end

    it "returns the match details when there is a match that day" do
      fake_page_with_match(provider.url)
      results = provider.run(team_name)
      details = {
        :country => "Spain",
        :league => "Liga BBVA",
        :time => "21:00",
        :team1 => "Athletic Bilbao",
        :team2 => "Barcelona"
      }

      expect(results).to eq(details)
    end
  end # of "#run"
end
