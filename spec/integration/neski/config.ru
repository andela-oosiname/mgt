require "./config/application.rb"
use Rack::Reloader, 0
use Rack::MethodOverride
NeskiApplication = Neski::Application.new
require "./config/routes.rb"

run NeskiApplication
