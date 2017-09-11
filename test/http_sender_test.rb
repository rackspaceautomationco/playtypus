require 'test_helper'
require 'time'

class HttpSenderTest < Playtypus::Test
 
  def test_initialize
    sender = Playtypus::HttpSender.new('http://localhost')
    assert_equal 'Playtypus::HttpSender', sender.class.name
  end

  def test_send_get
    sender = Playtypus::HttpSender.new('http://169.169.169.169')
    call = Playtypus::Call.new(Time.now.utc.iso8601, '/get', 'GET', nil, nil, nil) 
    sender.stubs(:send_http).with('get', 'http://169.169.169.169/get', { :headers => nil, :body => nil }).returns(200)
    response = sender.send call
    assert_equal 200, response
  end

  def test_send_get_encoded
    sender = Playtypus::HttpSender.new('http://169.169.169.169')
    call = Playtypus::Call.new(Time.now.utc.iso8601, '/get/foo\bar', 'GET', nil, nil, nil) 
    sender.stubs(:send_http).with('get', 'http://169.169.169.169/get/foo%5Cbar', { :headers => nil, :body => nil }).returns(200)
    response = sender.send call
    assert_equal 200, response
  end

  def test_send_get_fail_returns_nil
    sender = Playtypus::HttpSender.new('http://169.169.169.169')
    call = Playtypus::Call.new(Time.now.utc.iso8601, '/get/fail', 'GET', nil, nil, nil) 
    sender.stubs(:send_http).with('get', 'http://169.169.169.169/get/fail', { :headers => nil, :body => nil }).raises('fail!!!')
    response = sender.send call
    assert_nil response
  end

  def test_send_post
    sender = Playtypus::HttpSender.new('http://169.169.169.169')
    headers = { 'fizz' => 'buzz'}
    body = 'foobar'
    call = Playtypus::Call.new(Time.now.utc.iso8601, '/put/1', 'POST', headers, body, ' ') 
    sender.stubs(:send_http).with('post', 'http://169.169.169.169/put/1', { :headers => headers, :body => body }).returns(202)
    response = sender.send call
    assert_equal 202, response
  end

  def test_send_put
    sender = Playtypus::HttpSender.new('http://169.169.169.169')
    headers = { 'fizz' => 'buzz'}
    body = 'foobar'
    call = Playtypus::Call.new(Time.now.utc.iso8601, '/put/1', 'PUT', headers, body, ' ') 
    sender.stubs(:send_http).with('put', 'http://169.169.169.169/put/1', { :headers => headers, :body => body }).returns(202)
    response = sender.send call
    assert_equal 202, response
  end

  def test_send_delete
    sender = Playtypus::HttpSender.new('http://169.169.169.169')
    call = Playtypus::Call.new(Time.now.utc.iso8601, '/delete/2', 'DELETE', nil, nil, nil)
    sender.stubs(:send_http).with('delete', 'http://169.169.169.169/delete/2', { :headers => nil, :body => nil}).returns(204)
    response = sender.send call
    assert_equal 204, response
  end

end
