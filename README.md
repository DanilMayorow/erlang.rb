# Erlang.rb

A dead simple gem to decode Erlang Binary Terms into Ruby Terms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'erlang_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install erlang_ruby

## Usage

Use `Decoder` to transform an Erlang term (in binary) to a Ruby term:

```erlang
1> Name = milton.
milton
2> term_to_binary(Name).
<<131,100,0,6,109,105,108,116,111,110>>
```

Copy the binary value from the erlang shell to a ruby console:

```ruby
./bin/console
1> binary_data = [131,100,0,6,109,105,108,116,111,110].pack("C*");1
=> "\x83d\x00\x06milton"
2 > ErlangRuby::Decoder.perform(binary_data)
=> :milton
```

You can also decode tuples:
```erlang
1> T = term_to_binary({colours, such, as, {orange, blue}, are, cool}).
<<131,104,6,100,0,7,99,111,108,111,117,114,115,100,0,4,
  115,117,99,104,100,0,2,97,115,104,2,100,0,...>>
```

```ruby
./bin/console
1> binary_data = [131,104,6,100,0,7,99,111,108,111,117,114,115,100,0,4,115,117,99,104,100,0,2,97,115,104,2,100,0,6,111,114,97,110,103,101,100,0,4,98,108,117,101,100,0,3,97,114,101,100,0,4,99,111,111,108].pack("C*")
=> "\x83h\x06d\x00\acoloursd\x00\x04suchd\x00\x02ash\x02d\x00\x06oranged\x00\x04blued\x00\x03ared\x00\x04cool"
2 > ErlangRuby::Decoder.perform(binary_data)
=> [:colours, :such, :as, [:orange, :blue], :are, :cool]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/e2r. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
