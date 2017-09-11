# encoding: utf-8
require 'test_helper'

class GatewayTest < Playtypus::Test
  
 def test_empty
    try_sending(0)
  end

  def test_one
    try_sending(1)
  end

  def test_multiple
    try_sending(10)
  end

  def test_spread
    try_sending( nil, [
      Time.now,
      Time.now + 0.1,
      Time.now + 0.2
    ])
  end

  private

  def try_sending(count, list_of_times = nil)

    call_list = []
    if(list_of_times)
      count = list_of_times.size
      list_of_times.each do |time|
        call_list << build_mock_call(time)
      end
    else
      count.times do
        call_list << build_mock_call()
      end
    end

    sender = build_mock_sender()

    assert_equal(call_list.size, count, "Call list not populated with the right number of calls.")
    old_call_list_size = call_list.size

    gw = Playtypus::Gateway.new(call_list, sender, false, '') 

    gw.playback

    assert_equal(old_call_list_size, call_list.size, "Call list was modified by the gateway.")
    assert_equal(call_list.size, sender.call_count,  "Gateway invoked the sender the wrong number of times.")
  end

  def build_mock_sender
    return (Class.new Object do
      attr_reader :call_count
      def initialize
        @call_count = 0
      end
      def send(call)
        @call_count += 1
        return (Class.new Object do
          attr_reader :response
          attr_reader :headers
          attr_reader :parsed_response

          def initialize
            @headers = { "X-AUTH-TOKEN" => "123456789"}
            @parsed_response = 'foo'
            @response = (Class.new Object do
              attr_reader :code

              def initialize
                @code = '200'
              end
            end).new
          end
        end).new
      end 
    end).new
  end

  def build_mock_call(timestamp = Time.now)
    return (Class.new Object do
              attr_reader :timestamp
              attr_reader :response_filename
      def initialize(ts)
        @timestamp = ts
        @response_filename = nil
      end
    end).new(timestamp)
  end
 
end
