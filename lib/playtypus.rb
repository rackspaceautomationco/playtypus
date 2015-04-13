require 'logger'

$logger = Logger.new(STDOUT) unless $logger

require 'playtypus/call'
require 'playtypus/call_container'
require 'playtypus/gateway'
require 'playtypus/http_sender'
require 'playtypus/cli'

module Playtypus

end