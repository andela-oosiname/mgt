require "mgt/version"
require "mgt/util"
require "mgt/dependencies"
require "mgt/base_controller"
require "routing/router"
require "routing/route"
require "routing/mapper"

module Mgt
  class Application
    attr_reader :routes

    def initialize
      @routes = Routing::Router.new
    end

    def call(env)
      @request = Rack::Request.new(env)
      route = mapper.map_to_route(@request)

      if route
        response = route.dispatch
        return [200, { "Content-Type" => "text/html" }, [response]]
      end
      [404, {}, ["Page not found"]]
    end

    def mapper
      @mapper ||= Routing::Mapper.new(routes.endpoints)
    end
  end
end
