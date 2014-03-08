require 'spec_helper'

describe FCReminder::Providers::LiveScore do
  subject(:provider) { FCReminder::Providers::LiveScore.new }
  let(:team_name) { "Barcelona" }

  context "#initialize" do
    it { expect(provider).to be_kind_of(FCReminder::Providers::Base) }
  end

  context "#url" do
    it "should be valid" do
      expect(provider.url).to match(/^#{URI::regexp}$/)
    end
  end

  context "#run" do
    let(:default_value) { FCReminder::Providers::Base.new.run(team_name) }

    context "when there is no match that day" do
      before { fake_page_without_match(provider.url) }
      subject(:results) { provider.run(team_name) }

      it { expect(results).to eq(default_value) }
    end

    context "when there is a match that day" do
      before { fake_page_with_match(provider.url) }
      subject(:results) { provider.run(team_name) }

      it { expect(results).not_to eq(default_value) }

      context "has correct structure" do
        %w(country league time team1 team2).each do |attr|
          it { expect(results).to have_key(attr.to_sym) }
        end
      end

      context "has correct types" do
        it { expect(results).to be_an_instance_of(Hash) }

        %w(country league time team1 team2).each do |attr|
          it { expect(results[attr.to_sym]).to be_an_instance_of String }
        end
      end
    end
  end
end
