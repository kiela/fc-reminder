module FCReminder
  class Reminder
    attr_reader :provider, :gateway
    attr_accessor :team_name, :recipient

    def initialize(&customization_block)
      @provider = Providers::LiveScore.new
      @gateway = Gateways::Twilio.new
      eval_block &customization_block
    end

    def provider=(obj)
      if obj.kind_of? FCReminder::Providers::Base
        @provider = obj
      else
        raise 'Provider should inherits from FCReminder::Providers::Base'
      end
    end

    def gateway=(obj)
      if obj.kind_of? FCReminder::Gateways::Base
        @gateway = obj
      else
        raise 'Gateway should inherits from FCReminder::Gateways::Base'
      end
    end

    def run(&customization_block)
      eval_block &customization_block
      result = provider.run(team_name)
      gateway.send(recipient, result) unless result.empty?
    end

    private

      def eval_block(&block)
        block.call(self) if block_given?
      end
  end
end

