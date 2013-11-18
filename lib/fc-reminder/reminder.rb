module FCReminder
  class Reminder
    attr_accessor :test

    def initialize(&customization_block)
      eval_block &customization_block
    end

    def run(&customization_block)
      eval_block &customization_block
    end

    private

      def eval_block(&block)
        instance_eval(&block) unless block.nil?
      end
  end
end

