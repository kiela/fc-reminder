require 'rubygems'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task default: :spec

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'fc-reminder'
  ARGV.clear
  IRB.start
end
