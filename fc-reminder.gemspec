$:.push File.expand_path('../lib', __FILE__)
require 'fc-reminder/version'

Gem::Specification.new do |spec|
  spec.name         = 'fc-reminder'
  spec.version      = FCReminder::VERSION
  spec.authors      = ['Kamil Kieliszczyk']
  spec.email        = ['kamil@kieliszczyk.net']
  spec.description  = 'Simple reminder about an upcoming football game'
  spec.summary      = spec.description
  spec.homepage     = 'https://github.com/kiela/fc-reminder'

  spec.platform = Gem::Platform::RUBY
  spec.required_rubygems_version = '>= 1.3.6'

  spec.files          = `git ls-files`.split($/)
  spec.executables    = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ['lib']

  spec.add_dependency 'mechanize', '~> 2.7.3'
  spec.add_dependency 'twilio-ruby', '~> 3.11.5'
  spec.add_dependency 'mixlib-cli', '~> 1.4.0'
  spec.add_dependency 'daemons', '~> 1.1.9'
  spec.add_dependency 'clockwork', '~> 0.7.2'

  spec.add_development_dependency 'bundler', '~> 1.3'
end
