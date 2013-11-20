module FCReminder
  module Gateways
    class Base
      attr_accessor :config

      def send(recipient:, data:)
      end
    end
  end
end
