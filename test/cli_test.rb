require 'test_helper'

class CLITest < Playtypus::Test

  def test_play_with_directory
    @cli = Playtypus::CLI.new
    @cli.stubs(:options).returns({ :call_log => "#{File.dirname(__FILE__)}/" })
    @cli.play
  end

  def test_play_with_response_log
    @cli = Playtypus::CLI.new
    @cli.stubs(:options).returns({ :call_log => "#{File.dirname(__FILE__)}/", :response_log => "#{File.dirname(__FILE__)}/#{SecureRandom.uuid}"  })
    @cli.play
  end

  def test_play_with_file
    @cli = Playtypus::CLI.new
    @cli.stubs(:options).returns({ :call_log => "#{File.dirname(__FILE__)}/call_log.json" })
    @cli.play
  end

end
