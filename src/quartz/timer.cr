# The Timer class is a convenience wrapper that uses `spawn` and
# `sleep` to call a block in the future

module Quartz
  class Timer
    def initialize(seconds : Number, &block)
      @canceled = false
      raise ArgumentError.new "sleep seconds must be positive" if seconds < 0
      spawn do
        sleep(seconds)
        next if @canceled
        block.call
      end
    end

    def initialize(time : Time::Span, &block)
      initialize(time.total_seconds, &block)
    end

    def canceled?
      @canceled
    end

    def cancel
      @canceled = true
    end
  end
end
