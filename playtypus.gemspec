# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'playtypus'
  s.version     = '0.0.1'
  s.date        = '2015-04-09'
  s.required_ruby_version = '>= 1.9.3'
  s.licenses    = ['MIT']

  s.summary     = 'A command line utility that plays HTTP calls'
  s.description = 'The Playtypus is an eventmachine-based command line utility that plays HTTP calls'
  s.author      = 'Rackspace'
  s.email       = ['racksburg_automation@lists.rackspace.com']
  s.homepage    = 'https://github.com/rackspaceautomationco/playtypus'
  
  s.files = Dir.glob("{bin,lib}/**/*") + %w(MIT-LICENSE README.md Gemfile playtypus.gemspec ascii.rb)
  s.executables = %w(playtypus)

  s.add_dependency 'thor', '~> 0.19.1', '>= 0.19.1'
  s.add_dependency 'rake', '~> 10.1.0', '>= 10.1.0'
  s.add_dependency 'minitest', '~> 5.2.0', '>= 5.2.0'
  s.add_dependency 'simplecov', '~> 0.9.2', '>= 0.9.2'
  s.add_dependency 'coveralls', '~> 0.7.11', '>= 0.7.11'
  s.add_dependency 'pry', '~> 0.10.1', '>= 0.10.1'
  s.add_dependency 'httparty', '~> 0.11.0', '>= 0.11.0'
  s.add_dependency 'eventmachine', '~> 1.0.3', '< 1.0.4'
  s.add_dependency 'mocha', '~> 0.14.0', '>= 0.14.0'
end
