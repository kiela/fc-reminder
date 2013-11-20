require 'fc-reminder/version'
require 'fc-reminder/reminder'
require 'fc-reminder/gateways/base'
require 'fc-reminder/gateways/twilio'
require 'fc-reminder/providers/base'
require 'fc-reminder/providers/livescore'

module FCReminder
  def self.build(&customization_block)
    Reminder.new(&customization_block)
  end
end
