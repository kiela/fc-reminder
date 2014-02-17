require 'spec_helper'

describe FCReminder::Gateways::Base do
  subject(:gateway) { FCReminder::Gateways::Base.new }

  context "setters" do
    it "allows to set config attribute" do
      config = { foo: 'bar' }
      expect(gateway.config).to be_nil
      gateway.config = config
      expect(gateway.config).to eq(config)
    end
  end

  context "#send" do
    it "responds to send method" do
      expect(gateway).to respond_to(:send)
    end
  end
end

