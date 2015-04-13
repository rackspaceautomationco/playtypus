# example
# ruby ./bin/playtypus play --host=http://localhost:8081/ --call-log=/Users/justin/git/primary/Automation/DataRepository/exchange_service_api/smoke_tests/playback_service_api_primer/exchange_crud_api.json --log-responses --preserve-times

require 'thor'
require 'fileutils'

module Playtypus
  class CLI < Thor
    include Thor::Actions

    desc "play", "plays the playtypus"
    method_option :host, :type => :string, :aliases => '-h', :required => true
    method_option :call_log, :type => :string, :aliases => '-c', :required => true
    method_option :response_log, :type => :string, :aliases => '-r', :default => ''
    method_option :preserve_times, :type => :boolean, :aliases => '-p', :default => false
    def play(*args)
      require_relative '../../ascii.rb'
      $logger.debug "playtypus is playing with options #{options.inspect}"
      
      sender = Playtypus::HttpSender.new(options[:host])
      preserve_times = options[:preserve_times]
      calls = []

      if File.directory? options[:call_log]
        $logger.info "--call-log is a directory.  calls will be sent in order, without --preserve-times"
        preserve_times = false
        logs = Dir.glob("#{options[:call_log]}/**/*.json")
        logs.each do |log|
          calls.concat(Playtypus::CallContainer.from_log(File.read(log)).calls)
        end
      else
        log_file = File.read(options[:call_log])
        calls = Playtypus::CallContainer.from_log(log_file).calls
      end
      unless options[:response_log].to_s.empty?
        FileUtils.mkdir_p options[:response_log]
      end
      gateway = Playtypus::Gateway.new(calls, sender, preserve_times, options[:response_log])
      gateway.playback()
    end

    map 'p' => :play
  end
end