[![Build Status](https://travis-ci.org/andela-oosiname/mgt.svg?branch=master)](https://travis-ci.org/andela-oosiname/mgt)
[![Code Climate](https://codeclimate.com/github/andela-oosiname/mgt/badges/gpa.svg)](https://codeclimate.com/github/andela-oosiname/mgt)
[![Coverage Status](https://coveralls.io/repos/github/andela-oosiname/mgt/badge.svg?branch=master)](https://coveralls.io/github/andela-oosiname/mgt?branch=master)


# Mgt

Mgt is a MVC mini-framework, modeled after rails. Like Rails, Mgt is built using Ruby. The framework also comes with a minified ORM.

Mgt is ligthweight and hence fit for simple and quick applications. It makes available some of the great features of rails.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mgt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mgt

## Usage

When creating a new Mgt app, a few things need to be setup and a few rules adhered to. Mgt basically follows the same folder structure as a typical rails app with all of the model, view and controller code packed inside of an app folder, configuration based code placed inside a config folder and the main database file in a db folder.

View a sample app built using mgt framework [Here](https://github.com/andela-oosiname/neski)

## Key Features

### Routing
Routing with Mgt deals with directing requests to the appropriate controllers. A sample route file is:

```ruby
TodoApplication.routes.draw do
  get "/todo", to: "todo#index"
  get "/todo/new", to: "todo#new"
  post "/todo", to: "todo#create"
  get "/todo/:id", to: "todo#show"
  get "/todo/:id/edit", to: "todo#edit"
  patch "/todo/:id", to: "todo#update"
  put "/todo/:id", to: "todo#update"
  delete "/todo/:id", to: "todo#destroy"
end
```
Mgt supports GET, DELETE, PATCH, POST, PUT requests.


### Models
All models to be used with the Mgt framework are to inherit from the ActiveRecord class provided by Mgt, in order to access the rich ORM functionalities provided. The ActiveRecord class acts as an interface between the model class and its database representation. A sample model file is provided below:

```ruby
class Todo < Mgt::BaseRecord
  table :todo
  attribute :id, type: :integer, primary_key: true
  attribute :title, type: :text, nullable: false
  attribute :body, type: :text, nullable: false
  attribute :status, type: :text, nullable: false
  attribute :created_at, type: :text, nullable: false
  create_table
end
```
The `table` method provided stores the table name used while creating the table record in the database.

The `attribute` method is provided to declare table columns, and their attributes. The first argument to `attribute` is the column name, while subsequent hash arguments are used to provide information about attributes.

The `type` argument represents the data type of the column. Supported data types by Mgt are:

  * integer (for numeric values)
  * boolean (for boolean values [true or false])
  * text    (for alphanumeric values)

The `primary_key` argument is used to specify that the column should be used as the primary key of the table. If this is an integer, the value is auto-incremented by the database.

The `nullable` argument is used to specify whether a column should have null values, or not.

While creating models, the id property declaration is optional. If this is is not provided, the Mgt ORM adds it automatically, and sets it as the primary key. Thus, it should only be set if you'd like to use a different type as the primary key.

On passing in the table name, and its properties, a call should be made to the `create_table` method to persist the model to database by creating the table.


### Controllers
Controllers are key to the MVC structure, as they handle receiving requests, interacting with the database, and providing responses. Controllers are placed in the controllers folder, which is nested in the app folder.

All controllers should inherit from the BaseController class provided by Mgt to inherit methods which simplify accessing request parameters and returning responses by rendering views.

A sample structure for a controller file is:

```ruby
class todoController < Mgt::BaseController
  def index
    @todos = Todo.all
  end

  def new
  end

  def show
    todo = Todo.find(params[:id])
  end

  def destroy
    todo.destroy
    redirect_to "/"
  end
end
```

Instance variables set by the controllers are passed to the routes while rendering responses.

Explicitly calling `render` to render template files is optional. If it's not called by the controller action, then it's done automatically by the framework with an argument that's the same name as the action. Thus, you can decide to call `render` explicitly when you want to render a view with a name different from the action.


### Views
Currently, view templates are handled through the Tilt gem, with the Erubis template engine. See https://github.com/rtomayko/tilt for more details.

View templates are mapped to controller actions and must assume the same nomenclature as their respective actions.Erbuis is used as the templating engine and files which are views are required to have the .erb file extension after the .html extension. Views are placed inside the `app/views` folder. A view to be rendered for the new action in the todoController for example is saved as `new.html.erb` in the todo folder, nested in the views folder.

### External Dependencies
The Mgt framework has a few dependencies. These are listed below, with links to source pages for each.

  * sqlite3     - https://github.com/sparklemotion/sqlite3-ruby
  * erubis      - https://rubygems.org/gems/erubis
  * bundler     - https://github.com/bundler/bundler
  * rake        - https://github.com/ruby/rake
  * rack        - https://github.com/rack/rack
  * rack-test   - https://github.com/brynary/rack-test
  * rspec       - https://github.com/rspec/rspec
  * tilt        - https://github.com/rtomayko/tilt

## Running the tests

Test files are placed inside the spec folder and have been split into two sub folders, one for unit tests and the other for integration tests. You can run the tests from your command line client by typing `rspec spec`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Limitations

This version of the gem does not

support model relationships.
implement callbacks.
support migration generation.
generate a schema.

## Contributing

To contribute to this work:

1. Fork it ( https://github.com/[andela-oosiname]/mgt )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. Wait



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

