guard 'bundler' do
  watch('Gemfile')
end

guard :rspec, cmd: 'rspec --fail-fast',
failed_mode: :keep, all_after_pass: false, all_on_start: false do
  watch('spec/spec_helper.rb')        { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$})  { "spec" }
  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/#{m[1]}_spec.rb" }
end

