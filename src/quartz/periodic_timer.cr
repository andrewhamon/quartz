require "./timer"

module Quartz
  class PeriodicTimer < Timer
    def initialize(seconds : Number, &block)
      @canceled = false
      raise ArgumentError.new "sleep seconds must be positive" if seconds < 0
      spawn do
        loop do
          sleep(seconds)
          break if @canceled
          block.call
        end
      end
    end
  end
end
