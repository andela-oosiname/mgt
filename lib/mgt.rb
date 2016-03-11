require "mgt/version"
require "mgt/util"
require "mgt/dependencies"

module Mgt
  class Application
    def call(env)
      @req = Rack::Request.new(env)
      path = @req.path_info
      request_method = @req.request_method.downcase
      return [500, {}, []] if path == "/favicon.ico"
      controller, action = get_controller_and_action(path, request_method)
      response = controller.new.send(action)
      [200, { "Content-Type" => "text/html" }, [response]]
    end

    def get_controller_and_action(path, verb)
      _, controller, action, others = path.split("/", 4)
      controller_class = controller.capitalize + "Controller"
      [Object.const_get(controller_class), action]
    end
  end
end
