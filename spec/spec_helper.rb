GEM_ROOT = File.expand_path("../../", __FILE__)
$:.unshift File.join(GEM_ROOT, "lib")

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'fc-reminder'
Dir[File.join(GEM_ROOT, "spec", "support", "**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    FakeWeb.allow_net_connect = false
  end

  config.after(:suite) do
    FakeWeb.allow_net_connect = true
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
