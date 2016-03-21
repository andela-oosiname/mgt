$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)
require "simplecov"
SimpleCov.start
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require "mgt"
require "rack"
require "rspec"
RSpec.shared_context type: :feature do
  require "capybara/rspec"
  before(:all) do
    app = Rack::Builder.parse_file(
      "#{__dir__}/integration/neski/config.ru"
    ).first
    Capybara.app = app
  end

  after :all do
    Todo.drop_table(todos)
    Todo.create_table
    Todo.destroy_all
  end
end
