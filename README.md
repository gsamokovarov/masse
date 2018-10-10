# Masse

Catch those Ruby errors by the masses!

## Installation

    $ gem install masse

## Usage

```ruby
SloppyRuntimeErrors = Masse[
  "Access Denied",
  "Cannot find remote server",
  /SSH Key \(\w+)\ cannot be found/,
  -> raised { dynamic_check_for(raised) },
]

begin
  Action.execute
rescue SloppyRuntimeErrors => err
  ErrorTracker.send(err)
end
```

🎉
