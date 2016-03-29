require "mgt/version"
require "mgt/util"
require "mgt/dependencies"
require "mgt/base_controller"
require "routing/router"
require "routing/route"
require "routing/mapper"
require "orm/origin"
require "orm/database"
require "orm/query_generator"

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
