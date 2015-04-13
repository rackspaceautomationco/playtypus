require 'test_helper'
require 'time'

class CallContainerTest < Playtypus::Test
    
    def test_from_log
      timestamp1 = Time.now.utc
      path1 = "/from_log1/#{SecureRandom.uuid}"
      verb1 = 'POST'
      headers1 = { 'header1' => SecureRandom.uuid }
      body1 = { 'foo' => 'bar'}

      timestamp2 = Time.now.utc+400
      path2 = "/from_log2/ßßßßß/#{SecureRandom.uuid}"
      verb2 = 'GET'
      headers2 = nil
      body2 = nil
      calls = <<-EOH
        [
          {
            "timestamp" : "#{timestamp1.iso8601}",
            "path" : "#{path1}",
            "verb" : "#{verb1}",
            "headers" : #{headers1.to_json},
            "body" : #{body1.to_json}
          },
          {
            "timestamp" : "#{timestamp2.iso8601}",
            "path" : "#{path2}",
            "verb" : "#{verb2}",
            "headers" : #{headers2.to_json},
            "body" : #{body2.to_json}
          }
        ]
      EOH
      call_container = Playtypus::CallContainer.from_log(calls)
      calls = call_container.calls
      assert_equal timestamp1.iso8601, calls.first.timestamp.iso8601
      assert_equal path1, calls.first.path
      assert_equal verb1, calls.first.verb
      assert_equal headers1, calls.first.headers
      assert_equal body1, calls.first.body

      assert_equal timestamp2.iso8601, calls.last.timestamp.iso8601
      assert_equal path2, calls.last.path
      assert_equal verb2, calls.last.verb
      assert_equal headers2, calls.last.headers
      assert_equal body2, calls.last.body
    end
  


end
