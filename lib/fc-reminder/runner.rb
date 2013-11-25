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
      set_reminder(@reminder, @options)
      @options[:daemon] ? daemonize(@options) : run
    end

    private

      def initialize_reminder
        FCReminder.build do |config|
          config.gateway.config = {
            account_sid: ENV['TWILIO_ACCOUNT_SID'],
            auth_token: ENV['TWILIO_AUTH_TOKEN'],
            phone_number: ENV['TWILIO_PHONE_NUMBER']
          }
        end
      end

      def set_reminder(reminer, options)
        Clockwork.every(1.day, 'fc-reminder.check', at: options[:check]) do
          reminder.run do |conf|
            conf.team_name = options[:team]
            conf.recipient = options[:recipient]
          end
        end
      end

      def run
        Clockwork::run
      end

      def daemonize(options)
        name = process_name(options)
        opts = daemonize_options(options)
        Daemons.run_proc(name, opts) { run }
      end

      def process_name(options)
        arr = [PROCESS_NAME]
        arr.push(options[:identifier] ? options[:identifier] : options[:team])
        arr.join('.')
      end

      def daemonize_options(options)
        {
          ARGV: options[:argv],
          dir_mode: :normal,
          dir: options[:dir],
          monitor: options[:monitor],
          log_dir: options[:logdir],
          log_output: options[:log]
        }
      end
  end
end

