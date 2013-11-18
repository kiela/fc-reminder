require 'mechanize'

module FCReminder
  module Providers
    class Base

      attr_reader :client

      def initialize
        @client = Mechanize.new do |agent|
          agent.user_agent_alias = "Linux Firefox"
        end
      end

      def run(team_name:)
        Hash.new
      end
    end
  end
end
