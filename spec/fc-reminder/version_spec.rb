require 'spec_helper'

describe FCReminder do
  context "VERSION" do
    it { expect(FCReminder::VERSION).not_to be_nil }
  end
end
