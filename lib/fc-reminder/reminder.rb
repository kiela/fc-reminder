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
      if obj.kind_of? Providers::Base
        @provider = obj
      else
        raise 'Provider should inherits from FCReminder::Providers::Base'
      end
    end

    def gateway=(obj)
      if obj.kind_of? Gateways::Base
        @gateway = obj
      else
        raise 'Gateway should inherits from FCReminder::Gateways::Base'
      end
    end

    def run(&customization_block)
      eval_block &customization_block
      result = provider.run(team_name: team_name)
      gateway.send(recipient: recipient, data: result)
    end

    private

      def eval_block(&block)
        instance_eval(&block) unless block.nil?
      end
  end
end

