# BaseBranch

A simple gem to which automatically manages unique databases across code repository branches for Rails projects.

## Description

This gem is designed for people who actively work across multiple branches for Rails projects. Quite often, each of these branches come with a set of database migrations that are not finalized.
Base Branch attempts to solve this issue by creating unique databases namespaced by the feature branch names and cloning the data in from the default database.
 
Using BaseBranch, it is assured that

  1. Feature Branches have a clean environment to work from.
  2. The default database tied to master branch will not suffer from migration artifacts from unmerged feature branches.
  3. Developers can drop and recreate databases used for feature branches with a peace of mind :) 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'base-branch', group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install base-branch
    
After installation, run:

    $ rails g base_branch:install
    
to complete the configuration process.

## Usage

### When creating branches:

Run:

    $ rake base_branch:create_branch
    
to create a branch specific database. If branch specific database is not present, the default database will be used when the app loads.

You may have to run a `spring stop` afterwards if you are using the `spring` gem in order to load the correct database.

## To-dos

  1. Create a task to check against merged feature branches and clean up the corresponding databases

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KernCheh/base-branch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

