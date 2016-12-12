require "./spec_helper"

short_duration = 0.1
medium_duration = 0.2
long_duration = 0.3

describe Timer do
  it "should call the block passed once time has elapsed" do
    block_called = false

    Timer.new(short_duration) do
      block_called = true
    end

    sleep(long_duration)

    block_called.should be_true
  end

  it "should not have called the block before time has elapsed" do
    block_called = false

    Timer.new(long_duration) do
      block_called = true
    end

    sleep(short_duration)

    block_called.should be_false
  end

  it "should not call the block if canceled" do
    block_called = false

    t = Timer.new(medium_duration) do
      block_called = true
    end

    sleep(short_duration)
    t.cancel

    sleep(medium_duration)

    block_called.should be_false
  end

  it "should not accept negative values" do
    expect_raises ArgumentError do
      block_called = false

      t = Timer.new(-1) do
        block_called = true
      end
    end
  end

  it "should accept a Time::Span" do
    block_called = false

    t = Timer.new(Time::Span.new(1)) do
      block_called = true
    end
  end
end
