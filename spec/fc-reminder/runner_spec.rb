require 'spec_helper'

describe FCReminder::Runner do
  let(:options) { {foo: "bar"} }

  describe "#initialize" do
    subject(:runner) { FCReminder::Runner.new(options) }

    it "sets #reminder" do
      expect(runner.reminder).to be_kind_of(FCReminder::Reminder)
    end
    it "sets #options" do
      expect(runner.options).to eq(options)
    end
  end

  context "setters" do
    subject(:runner) { FCReminder::Runner.new(options) }

    it { expect(runner).not_to respond_to(:options=) }
    it { expect(runner).not_to respond_to(:reminder=) }
  end

  describe "#start" do
    context "sets reminder" do
      subject(:runner) { FCReminder::Runner.new({ daemon: false }) }
      before do
        allow(Clockwork).to receive(:every) { |&block| block.call }
        allow(runner.reminder).to receive(:run)
        allow(runner).to receive(:run)
      end

      it do
        expect(runner.reminder).to receive(:run)
        runner.start
      end
    end

    context "starts normal process" do
      subject(:runner) { FCReminder::Runner.new({ daemon: false }) }
      before { allow(runner).to receive(:run) }

      it do
        expect(runner).to receive(:run)
        runner.start
      end
    end

    context "starts daemon process" do
      subject(:runner) { FCReminder::Runner.new({ daemon: true }) }
      before { allow(runner).to receive(:daemonize) }

      it do
        expect(runner).to receive(:daemonize)
        runner.start
      end
    end
  end
end

