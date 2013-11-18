require 'spec_helper'

describe FCReminder do
  context "#build" do
    it "returns an instance of FCReminder::Reminder" do
      expect(FCReminder.build).to be_instance_of(FCReminder::Reminder)
    end
  end
end

