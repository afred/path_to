# Path To

A simple class to handle conditional logic of looking for a file in multiple
paths.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'path_to'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install path_to

## Usage

Not unlike a `$PATH` environment variables, a `PathTo` instance contains one
or more locations to look for a file, and will return the first file it finds.

**Example:**

Suppose you have some files in the following directory structure:

```
├── default_files
│   └── alpha
│   └── bravo
├── specific_files
│   └── alpha
```

Then you can use `path_to` to add `specific_files` and `default_files` to the
locations to look for your files.

```ruby
require 'path_to'
p = PathTo.new('specific_files', 'default_files')
p.path_to 'alpha'
# => 'specific_files/alpha'
p.path_to 'bravo'
# => 'default_files/bravo'
```

And there is a shortcut for returning `File` objects.

```ruby
p.file('alpha')
# => #<File:specific_files/alpha> 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/path_to/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
