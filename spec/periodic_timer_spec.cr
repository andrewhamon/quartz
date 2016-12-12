require "./spec_helper"

period = 0.1

describe PeriodicTimer do
  it "calls the block until canceled" do
    call_count = 0

    t = PeriodicTimer.new(period) do
      call_count += 1
    end

    sleep(2.1 * period)
    t.cancel

    call_count.should eq(2)
  end
end
