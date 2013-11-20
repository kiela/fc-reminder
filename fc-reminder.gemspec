$:.push File.expand_path('../lib', __FILE__)
require 'fc-reminder/version'

Gem::Specification.new do |spec|
  spec.name         = 'fc-reminder'
  spec.version      = FCReminder::VERSION
  spec.authors      = ['Kamil Kieliszczyk']
  spec.email        = ['kamil@kieliszczyk.net']
  spec.description  = 'Simple reminder about an upcoming football game'
  spec.summary      = 'Simple reminder about an upcoming football game'
  spec.homepage     = 'https://github.com/kiela/fc-reminder'

  spec.platform = Gem::Platform::RUBY
  spec.required_rubygems_version = '>= 1.3.6'

  spec.files = `git ls-files`.split("\n")
  spec.require_path = ['lib']

  spec.add_dependency 'mechanize', '~> 2.7.3'
  spec.add_dependency 'twilio-ruby', '~> 3.11.4'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'fakeweb'
end
