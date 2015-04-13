require 'test_helper'
require 'time'
require 'json'

class CallTest < Playtypus::Test
    
    def test_initialize_post
      timestamp = Time.now.utc
      path = "/#{SecureRandom.uuid}"
      verb = "POST"
      headers = { 'header1' => 'foo', 'header2' => 'bar'}
      body = { 'body1' => 'fizz', 'body2' => 'buzz', 'list1' => [ '1', '2', '3'] }
      call = Playtypus::Call.new(timestamp.iso8601, path, verb, headers, body)
      assert_equal timestamp.iso8601, call.timestamp.iso8601
      assert_equal path, call.path
      assert_equal verb, call.verb
      assert_equal headers, call.headers
      assert_equal body, call.body
      from_hash = call.to_hash
      assert_equal timestamp.iso8601, from_hash['timestamp'].iso8601
      assert_equal path, from_hash['path']
      assert_equal verb, from_hash['verb']
      assert_equal headers, from_hash['headers']
      assert_equal body, from_hash['body']
      to_s = call.to_s
      hash_from_s = JSON.parse(to_s)
      assert_equal timestamp.to_s, hash_from_s['timestamp']
      assert_equal path, hash_from_s['path']
      assert_equal verb, hash_from_s['verb']
      assert_equal headers, hash_from_s['headers']
      assert_equal body, hash_from_s['body']
    end

    def test_initialize_get
      timestamp = Time.now.utc
      path = "/users/#{SecureRandom.uuid}"
      verb = "GET"
      headers = nil
      body = nil
      call = Playtypus::Call.new(timestamp.iso8601, path, verb, headers, body)
      assert_equal timestamp.iso8601, call.timestamp.iso8601
      assert_equal path, call.path
      assert_equal verb, call.verb
      assert_equal headers, call.headers
      assert_equal body, call.body
      from_hash = call.to_hash
      assert_equal timestamp.iso8601, from_hash['timestamp'].iso8601
      assert_equal path, from_hash['path']
      assert_equal verb, from_hash['verb']
      assert_equal headers, from_hash['headers']
      assert_equal body, from_hash['body']
      to_s = call.to_s
      hash_from_s = JSON.parse(to_s)
      assert_equal timestamp.to_s, hash_from_s['timestamp']
      assert_equal path, hash_from_s['path']
      assert_equal verb, hash_from_s['verb']
      assert_equal headers, hash_from_s['headers']
      assert_equal body, hash_from_s['body']
    end

    def test_from_hash
      timestamp = Time.now.utc
      path = "/resources/#{SecureRandom.uuid}"
      verb = "GET"
      headers = nil
      body = nil
      hash = {
        'timestamp' => timestamp.iso8601,
        'path' => path,
        'verb' => verb,
        'headers' => headers,
        'body' => body
      }
      call = Playtypus::Call.from_hash hash
      assert_equal timestamp.iso8601, call.timestamp.iso8601
      assert_equal path, call.path
      assert_equal verb, call.verb
      assert_equal headers, call.headers
      assert_equal body, call.body
    end
  
end
