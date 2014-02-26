require 'spec_helper'

describe FCReminder do
  context "#build" do
    it { expect(FCReminder.build).to be_instance_of(FCReminder::Reminder) }
  end
end

