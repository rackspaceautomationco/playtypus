require 'json'
require 'httparty'
require 'uri'

module HTTParty
  class Parser
    def self.call(body, format)
      begin
        new(body, format).parse
      rescue JSON::ParserError
        format = :plain
        retry
      end
    end
  end
end

module Playtypus
  class HttpSender
    include HTTParty

    class HttpSendError < Exception
    end

    def initialize(host)
      @host = host
    end

    def send(call)
      $logger.debug("sending call #{call.inspect}")
      body = transform_payload(call.body)
      $logger.debug "transformed body to #{body}"

      begin
        URI.parse("#{@host}#{call.path}")
        @url = "#{@host}#{call.path}"
      rescue URI::InvalidURIError
        @url = URI::encode("#{@host}#{call.path}")
      end
      
      $logger.info("sending call to #{@url}")
      response = nil

      begin
        response = send_http(call.verb.downcase, @url, { :body => body, :headers => call.headers })
      rescue => e
        $logger.warn "call failed with exception: #{e.inspect}"
      end

    unless(response == nil)
     $logger.debug "received response #{response.inspect}"
    end

    return response
  end

  private

  def send_http(verb, url, options)
    self.class.send(verb, url, options)
  end

  def transform_payload(input)
    result = nil
    begin
      result = JSON.pretty_generate(input)
    rescue
      result = input
    end
    return result
  end

end

end
