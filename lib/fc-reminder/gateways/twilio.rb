require 'twilio-ruby'

module FCReminder
  module Gateways
    class Twilio < Base
      def send(recipient, data)
        client = ::Twilio::REST::Client.new(
          config[:account_sid],
          config[:auth_token]
        )
        client.account.messages.create(
          from: config[:phone_number],
          to: recipient,
          body: message(data)
        )
      end

      private

        def message(data)
          if data.empty?
            "No match for today"
          else
            "Reminder of today's match in #{data[:country]} (#{data[:league]})"\
            " between #{data[:team1]} and #{data[:team2]} at #{data[:time]}"
          end
        end
    end
  end
end
