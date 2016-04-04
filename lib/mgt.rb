require "mgt/controller/base_controller"
require "mgt/orm/database"
require "mgt/orm/origin"
require "mgt/orm/query_generator"
require "mgt/routing/mapper"
require "mgt/routing/router"
require "mgt/routing/route"
require "mgt/utilities/dependencies"
require "mgt/utilities/util"
require "mgt/version"

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
