GEM_ROOT = File.expand_path("../../", __FILE__)
$:.unshift File.join(GEM_ROOT, "lib")

require 'fc-reminder'
Dir[File.join(GEM_ROOT, "spec", "support", "**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
