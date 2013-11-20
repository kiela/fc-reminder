module FCReminder
  class Reminder
    attr_reader :provider, :gateway
    attr_accessor :team_name, :recipient

    def initialize(&customization_block)
      eval_block &customization_block
      @provider = Providers::LiveScore.new
      @gateway = Gateways::Twilio.new
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

