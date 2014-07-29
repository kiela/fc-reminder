source 'https://rubygems.org'

gem  'rake'

group :development do
  gem 'guard', '~> 2.6.1'
  gem 'guard-bundler', '~> 2.0.0'
  gem 'guard-rspec', '~> 4.3.1'
  gem 'pry', '~> 0.10.0'
end

group :test do
  gem 'rspec', '~> 3.0.0'
  gem 'fakeweb', '~> 1.3.0'
  gem 'codeclimate-test-reporter', '~> 0.3.0', require: false
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
end

gemspec
