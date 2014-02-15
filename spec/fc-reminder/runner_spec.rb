require 'spec_helper'

describe FCReminder::Runner do
  let(:options) { {foo: "bar"} }

  context "#initialize" do
    subject(:runner) { FCReminder::Runner.new(options) }

    it "sets options" do
      expect(runner.options).to eq(options)
    end

    it "initializes reminder" do
      expect(runner.reminder).to be_an_instance_of(FCReminder::Reminder)
    end
  end

  context "setters" do
    subject(:runner) { FCReminder::Runner.new(options) }

    it "disallows to change options after initializing" do
      expect(runner).not_to respond_to(:options=)
    end

    it "disallows to change reminder after initializing" do
      expect(runner).not_to respond_to(:reminder=)
    end
  end

  context "#start" do
    it "sets reminder" do
      options = {daemon: false}
      runner = FCReminder::Runner.new(options)

      allow(Clockwork).to receive(:every) { |&block| block.call }
      allow(runner.reminder).to receive(:run)
      allow(runner).to receive(:run)

      expect(runner.reminder).to receive(:run)
      runner.start
    end

    it "starts normal process" do
      options = {daemon: false}
      runner = FCReminder::Runner.new(options)

      allow(runner).to receive(:run)

      expect(runner).to receive(:run)
      runner.start
    end

    it "starts daemon process" do
      options = {daemon: true}
      runner = FCReminder::Runner.new(options)

      allow(runner).to receive(:daemonize)

      expect(runner).to receive(:daemonize)
      runner.start
    end
  end
end

