require 'spec_helper'

describe FCReminder::Providers::Base do
  subject(:provider) { FCReminder::Providers::Base.new }

  describe "#initialize" do
    it "sets #client" do
      expect(provider.client).to be_instance_of Mechanize
    end
  end

  describe "#client" do
    it { expect(provider).not_to respond_to(:client=) }
  end

  describe "#url" do
    it { expect(provider.url).to be_empty }
  end

  describe "#run" do
    let(:team_name) { "Team Name" }

    it { expect(provider.run(team_name)).to be_instance_of(Hash) }
    it { expect(provider.run(team_name)).to be_empty }
  end
end

