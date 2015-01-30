# EnomRuby

A ruby wrapper for the [Enom Reseller](http://www.enom.com/resellers/api-documentation.aspx) API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enom-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enom-ruby

## Usage

TODO: Write usage instructions here

```ruby
EnomRuby::Client.configure do |c|
  c.username = ENV['ENOM_USERNAME']
  c.password = ENV['ENOM_PASSWORD']
  c.test_mode = true
end
```

## Contribute

1. Fork it ( https://github.com/[my-github-username]/enom-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Mentions

Most of this gem is stemmed from James Miller's [Enom](https://github.com/bensie/enom) gem. It worked well, but now I need to add some new things, and check against new TLDs which the enom gem fails with. I also have no use for a command line version
