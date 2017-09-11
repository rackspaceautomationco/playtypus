require 'json'
require 'time'

module Playtypus
  class Call
    attr_accessor :timestamp,
      :path,
      :verb,
      :headers,
      :body,
      :response_filename

    def self.from_hash(hash)
      return self.new(hash['timestamp'], hash['path'], hash['verb'], hash['headers'], hash['body'], hash['response_filename'])
    end

    def initialize(timestamp, path, verb, headers, body, response_filename)
      @timestamp = Time.iso8601(timestamp)
      @path = path
      @verb = verb
      @headers = headers
      @body = body
      @response_filename = response_filename
    end

    def to_hash
      {
        'timestamp' => @timestamp,
        'path' => @path,
        'verb' => @verb,
        'headers' => @headers,
        'body' => @body,
	'response_filename' => @response_filename
      }
    end

    def to_s
      self.to_hash.to_json
    end
  end
end
