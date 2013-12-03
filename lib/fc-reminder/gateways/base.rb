module FCReminder
  module Gateways
    class Base
      attr_accessor :config

      def send(recipient: _, data: _)
      end
    end
  end
end
