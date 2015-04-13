require 'eventmachine'
require 'json'

module Playtypus
  class Gateway

    def initialize(call_list, sender, preserve_times, response_log)
      @call_list = call_list.clone.freeze
      @sender = sender
      @preserve_times = preserve_times
      @response_log = response_log
    end

    def playback()

      if(@call_list.size == 0)
        return
      end

      @diff = Time.now.utc - @call_list.first.timestamp
      @ticks = 0
      @position = 0
      EventMachine.run do
        Signal.trap("INT")  { EventMachine.stop }
        Signal.trap("TERM") { EventMachine.stop }
        EM.add_periodic_timer(0.01) {
          current = Time.now.utc - @diff
          while(@position < @call_list.size)
            call = @call_list[@position]
            if(!(@preserve_times) || (call.timestamp <= current))
              result = @sender.send(call)
              $logger.info "#{self.class.name}: waited #{@ticks} ticks.  sent message #{call.timestamp}"
              unless @response_log.to_s.empty?
                begin
                  File.open("#{@response_log}/#{@position.to_s.rjust(10, '0')}.log", 'w+') do |file|
                      file.write(JSON.pretty_generate({ 'code' => result.response.code, 'headers' => result.headers.to_hash, 'body' => result.parsed_response}))
                  end
                rescue => e
                  $logger.warn "failed to log response with exception: #{e.inspect}"
                end
              end
              @position += 1
              @ticks = 0
            else
              @ticks += 1
              break
            end
          end
          if(@position >= @call_list.size)
            EventMachine.stop
          end
        }
      end
    end
  end

end
