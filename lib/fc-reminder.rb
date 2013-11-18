require 'fc-reminder/version'
require 'fc-reminder/reminder'
require 'fc-reminder/gateway'
require 'fc-reminder/provider'

module FCReminder
  def self.build(&customization_block)
    Reminder.new(&customization_block)
  end
end
