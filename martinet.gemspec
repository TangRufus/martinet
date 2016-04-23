# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'martinet/version'

Gem::Specification.new do |spec|
  spec.name          = 'martinet'
  spec.version       = Martinet::VERSION
  spec.authors       = ['Tang Rufus']
  spec.email         = ['tangrufus@gmail.com']

  spec.summary       = 'Authorization component for warden and omniauth. Devise-less'
  spec.description   = 'Authorization component for warden and omniauth. Devise-less'
  spec.homepage      = 'https://github.com/TangRufus/martinet'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = 'lib'

  spec.required_ruby_version = '>= 2.1.10'

  spec.add_dependency 'warden', '~> 1.2', '>= 1.2.6'

  spec.add_development_dependency 'bundler', '~> 1.11', '>= 1.11.2'
  spec.add_development_dependency 'rake', '~> 11.1', '>= 11.1.2'
  spec.add_development_dependency 'appraisal', '~> 2.1.0'
  spec.add_development_dependency 'minitest', '~> 5.8', '>= 5.8.4'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.5.0'
  spec.add_development_dependency 'activerecord', '>= 4.0.13'
  spec.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
end