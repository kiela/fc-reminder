require 'spec_helper'

describe FCReminder::Runner do
  let(:options) { {foo: "bar"} }

  describe "#initialize" do
    subject(:runner) { FCReminder::Runner.new(options) }

    it "sets #options" do
      expect(runner.options).to eq(options)
    end
    it "sets #reminder" do
      expect(runner.reminder).to be_kind_of(FCReminder::Reminder)
    end
  end

  context "setters" do
    subject(:runner) { FCReminder::Runner.new(options) }

    it { expect(runner).not_to respond_to(:options=) }
    it { expect(runner).not_to respond_to(:reminder=) }
  end

  describe "#start" do
    before do
      allow(Clockwork).to receive(:every) { |&block| block.call }
      allow(runner.reminder).to receive(:run)
      allow(runner).to receive(:run)
    end

    context "sets reminder" do
      subject(:runner) { FCReminder::Runner.new({ daemon: false }) }

      it "calls Clockwork.every" do
        expect(Clockwork)
          .to receive(:every)
          .with(1.day, anything(), { at: anything() })

        runner.start
      end
    end

    context "starts normal process" do
      subject(:runner) { FCReminder::Runner.new({ daemon: false }) }

      it "runs" do
        expect(runner).to receive(:run)
        runner.start
      end
    end

    context "starts daemon process" do
      subject(:runner) { FCReminder::Runner.new({ daemon: true }) }
      before { allow(Daemons).to receive(:run_proc) }

      it "calls Daemons.run_proc" do
        expect(Daemons)
          .to receive(:run_proc)
          .with(anything(), anything())

        runner.start
      end
    end
  end
end

