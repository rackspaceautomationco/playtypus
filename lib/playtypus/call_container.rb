require 'json'

module Playtypus
  class CallContainer

    attr_accessor :calls

    def self.from_log(log_content)
      calls = []
      json = JSON.parse(log_content.force_encoding("utf-8"))
      json.each do |log_entry|
        calls << Playtypus::Call.from_hash(log_entry)
      end
      return self.new(calls.sort_by{ |k| k.timestamp})
    end

    def initialize(calls)
      @calls = calls
    end

  end
end