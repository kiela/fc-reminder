require 'spec_helper'

describe FCReminder::Providers::Base do
  subject(:provider) { FCReminder::Providers::Base.new }
  let(:team_name) { "Barcelona" }

  context "#initialize" do
    it "initializes HTTP client" do
      expect(provider.client).not_to be_nil
    end

    it "disallows to change client" do
      expect(provider).not_to respond_to(:client=)
    end
  end

  context "#url" do
    it "returns empty string" do
      expect(provider.url).to be_empty
    end
  end

  context "#run" do
    it "returns empty instance of Hash" do
      expect(provider.run(team_name)).to be_instance_of(Hash)
      expect(provider.run(team_name)).to be_empty
    end
  end
end

