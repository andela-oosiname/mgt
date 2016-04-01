require "mgt/base_controller"
require "mgt/dependencies"
require "mgt/util"
require "mgt/version"
require "orm/database"
require "orm/origin"
require "orm/query_generator"
require "routing/mapper"
require "routing/router"
require "routing/route"

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
        route.dispatch
      else
        [404, {}, ["Page not found"]]
      end
    end

    def mapper
      @mapper ||= Routing::Mapper.new(routes.endpoints)
    end
  end
end
