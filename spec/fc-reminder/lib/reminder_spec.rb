require 'spec_helper'

describe FCReminder::Reminder do
  let(:test) { "Test Value" }

  context "#initialize" do
    it "allows to configure reminder by using a block" do
      value = test
      reminder = FCReminder::Reminder.new { |config| config.test = value }
      expect(reminder.test).to eq(value)
    end
  end

  context "setters" do
    it "allows to configure reminder by using setters" do
      reminder = FCReminder::Reminder.new
      reminder.test = test
      expect(reminder.test).to eq(test)
    end
  end

  context "#run" do
    it "allows to set consumer data by using a block" do
      value = test
      reminder = FCReminder::Reminder.new
      reminder.run { |config| config.test = value }
      expect(reminder.test).to eq(value)
    end
  end
end
