# Quartz

Dead simple timers in Crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  timer:
    github: andrewhamon/quartz
```

## Usage

```crystal
require "quartz"

# Execute a block after 3 seconds
Quartz::Timer.new(3) do
  puts "3 seconds"
end

# Execute block every second
Quartz::PeriodicTimer.new(1) do
  puts "tick"
end

# Make sure you yield in some way so that the timers get scheduled
sleep(5)
```

## WARNING: Make sure you understand Crystal's concurrency model

Crystal is concurrent, but not (yet) parallel. Crystal fibers don't run immediately after being spawned, the main fiber must yield control, either explicitly by sleeping or implicitly by doing blocking IO.

See [the docs](https://crystal-lang.org/docs/guides/concurrency.html) for a more detailed explanation.

This has a number of consequences for timers such as this library:

- The countdown for a timer doesn't start when the timer is instantiated, only when the fiber it spawns runs. This could be an arbitrarily long time after the timer is instantiated.
- The block you pass your timer might never get called, if the main fiber terminates too early or if it never yields control.
- Different timers might fire in a different order than expected. A shorter timer could fire after a longer timer
- Timers are not precise.
- A shorter timer is not guaranteed to execute before a separate, longer timer.


## Contributing

1. Fork it ( https://github.com/andrewhamon/quartz/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [andrewhamon](https://github.com/andrewhamon) Andrew Hamon - creator, maintainer
