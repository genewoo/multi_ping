# multi_ping

For some reasons, you need to check network connection statics to more than one server. 

## Installation

Install it yourself as:

    $ gem install multi_ping

## Usage

```
  Usage 1: multi_ping [options] hosts...
  Usage 2: multi_ping [options] < host_file (one host each line)
  Usage 3: echo hosts... || multi_ping [options]
    -c, --count COUNT                Ping Count
    -s, --size SIZE                  Ping Package Size
    -p, --parallel PARALLEL          Parallel running
    -l, --list                       server list only
 ```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/genewoo/multi_ping. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

