require 'spec_helper'

describe FCReminder::Providers::Base do
  subject { FCReminder::Providers::Base.new }
  let(:team_name) { "Barcelona" }

  context "#initialize" do
    it "initializes HTTP client" do
      expect(subject.client).not_to be_nil
    end

    it "disallows to change client" do
      expect(subject).not_to respond_to(:client=)
    end
  end

  context "#run" do
    it "returns empty instance of Hash" do
      expect(subject.run(team_name: team_name)).to be_instance_of(Hash)
      expect(subject.run(team_name: team_name)).to be_empty
    end
  end
end
