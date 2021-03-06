require 'spec_helper'

describe FCReminder::Gateways::Base do
  subject(:gateway) { FCReminder::Gateways::Base.new }

  describe "#config" do
    let(:config) { { foo: "bar" } }

    it do
      expect{ gateway.config = config }
        .to change{ gateway.config }
        .from(nil)
        .to(config)
    end
  end

  describe "#send" do
    it { expect(gateway).to respond_to(:send).with(2).arguments }
  end
end

