require 'simplecov'
require 'coveralls'
require 'minitest'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
]

SimpleCov.start do
  add_filter '/test/'
  add_filter '/ascii.rb'
end

require 'tmpdir'
require 'minitest/autorun'
require 'mocha/setup'

require_relative '../lib/playtypus'

WORKING_DIRECTORY = Dir.pwd.freeze
ARGV.clear

module Playtypus
  class Test < Minitest::Test

      $logger = Logger.new('/dev/null')

  end
end
