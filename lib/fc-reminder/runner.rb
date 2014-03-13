require 'daemons'
require 'clockwork'

module FCReminder
  class Runner
    PROCESS_NAME = 'FCReminder'
    attr_reader :options, :reminder

    def initialize(options)
      @options = options
      @reminder = initialize_reminder
    end

    def start
      set_reminder
      @options[:daemon] ? daemonize : run
    end

    private

      def initialize_reminder
        FCReminder.build do |reminder|
          reminder.gateway.config = {
            account_sid: ENV['TWILIO_ACCOUNT_SID'],
            auth_token: ENV['TWILIO_AUTH_TOKEN'],
            phone_number: ENV['TWILIO_PHONE_NUMBER']
          }
        end
      end

      def set_reminder
        Clockwork.every(1.day, 'fc-reminder.check', at: @options[:check]) do
          @reminder.run do |config|
            config.team_name = @options[:team]
            config.recipient = @options[:recipient]
          end
        end
      end

      def run
        Clockwork::run
      end

      def daemonize
        Daemons.run_proc(process_name, daemonize_options) { run }
      end

      def process_name
        [
          PROCESS_NAME,
          (@options[:identifier] ? @options[:identifier] : @options[:team])
        ].join('.')
      end

      def daemonize_options
        {
          ARGV: @options[:argv],
          dir_mode: :normal,
          dir: @options[:dir],
          monitor: @options[:monitor],
          log_dir: @options[:logdir],
          log_output: @options[:log]
        }
      end
  end
end

