require 'json'
require 'httparty'
require 'uri'
require 'rexml/document'
include REXML

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
    result = input
    begin
      result = JSON.pretty_generate(input) unless is_xml(input)
    rescue
    end
    return result
  end

  def is_xml(input)
    isxml = nil
    begin
      Document.new(input)
      isxml=true
    rescue
      isxml=false
    end
    return isxml
  end

end

end
