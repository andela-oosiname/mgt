require "coveralls"
require "mgt"
require "rack"
require "rspec"

Coveralls.wear!
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)

RSpec.shared_context type: :feature do
  require "capybara/rspec"
  before(:all) do
    app = Rack::Builder.parse_file(
      "#{__dir__}/integration/neski/config.ru"
    ).first
    Capybara.app = app
  end
end
