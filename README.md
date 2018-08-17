# Todoable

This gem wraps the Teachable Todoable To To List API


## Installation

Add the following to your gemfile:

```ruby
gem 'todoable', :git => 'git://github.com/twitnithegirl/todoable.git'
```

And then execute:

    $ bundle

## Usage

First, get a new instance of the Todoable Client like

```ruby
todoable = Todoable::Client.new(username: "your username", password: "your password")
```
Both Username and Password are required and you will not be able to create the client without passing them in.

Once you have the client you have several methods available to you. 
You can call them like:
```ruby
todoable.finish_item(list_id: <list id>, item_id: <item id>)
```

### Available methods

| Method        | Required Inputs                     | Return Hash                                                   |
|---            |---                                  |---                                                            |
|#lists         | NONE                                |{ 'body': \[{ <all lists> }],      'code': <response code> }   |
|#new_list      | name:     String                    |{ 'body': {<list body>},           'code': <response code> }   |
|#find_list     | id:       String                    |{ 'body': {<list body>},           'code': <response code> }   |
|#update_list   | id:       String, name:     String  |{ 'body': "<list name> updated",   'code': <response code> }   |
|#delete_list   | id:       String                    |{ 'body': nil,                     'code': <response code> }   |
|#new_item      | list_id:  String, name:     String  |{ 'body': {<item body>},           'code': <response code> }   |
|#finish_item   | list_id:  String, item_id:  String  |{ 'body': "<item name> finished",  'code': <response code> }   |
|#delete_item   | list_id:  String, item_id:  String  |{ 'body': nil,                     'code': <response code> }   |

If a method is unsuccessful you will get back an error response in the same hash format with information on the failure.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `ruby test/<filename>` to run a test file.

`pry` is built into dev so you can use it to debug and step through tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/twitnithegirl/todoable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Todoable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/todoable/blob/master/CODE_OF_CONDUCT.md).
