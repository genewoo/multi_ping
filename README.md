# multi_ping

For some reasons, you need to check network connection statics to more than one server. 

## Installation

Install it yourself as:

    $ gem install multi_ping

## Usage

You need to run ```multi_ping``` with a root privilege, ie. in rvm and sudo, ```rvmsudo multi_ping```

```
  Usage 1: multi_ping [options] hosts...
  Usage 2: multi_ping [options] < host_file (one host each line)
  Usage 3: echo hosts... || multi_ping [options]
    -c, --count COUNT                Ping Count
    -p, --parallel PARALLEL          Parallel running
    -v, --verbose                    Print log verbose
    -t, --threashold COUNT           Stop ping once reach the threashold
```

## Sample Output

It will stop ping the host once 1/5 or total count of pacage was dropped

```
tw.sina.com.cn, 90.2926, 100.0
sg.sina.com.cn, 97.802, 100.0
jp.sina.com.cn, 113.5288, 100.0
hk.sina.com.cn, 179.8547, 100.0
us.sina.com.cn, 264.4235, 100.0
uk.sina.com.cn, 297.1144, 100.0
nothing.nil, 9999.0, 0.0
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/genewoo/multi_ping. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

