require 'spec_helper'

describe FCReminder::Providers::Base do
  subject(:provider) { FCReminder::Providers::Base.new }
  let(:team_name) { "Barcelona" }

  context "#initialize" do
    context "client" do
      it { expect(provider.client).to be_instance_of Mechanize }
    end
  end

  context "'client' attribute" do
    it { expect(provider).not_to respond_to(:client=) }
  end

  context "#url" do
    it { expect(provider.url).to be_empty }
  end

  context "#run" do
    it { expect(provider.run(team_name)).to be_instance_of(Hash) }
    it { expect(provider.run(team_name)).to be_empty }
  end
end

