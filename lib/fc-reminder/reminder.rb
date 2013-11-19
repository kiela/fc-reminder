module FCReminder
  class Reminder
    attr_accessor :team_name
    attr_reader :provider

    def initialize(&customization_block)
      eval_block &customization_block
      @provider = Providers::LiveScore.new
    end

    def run(&customization_block)
      eval_block &customization_block
      provider.run(team_name: team_name)
    end

    private

      def eval_block(&block)
        instance_eval(&block) unless block.nil?
      end
  end
end

