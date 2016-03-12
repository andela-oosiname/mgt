require "tilt"

module Mgt
  class BaseController
    attr_reader :request
    def initialize(env)
      @request = Rack::Request.new(env)
    end

    def render(view_name, locals = {})
      template = Tilt::ERBTemplate.new(File.join("app", "views", controller_name, "#{view_name}.html.erb"))
      template.render(self, locals)
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end
  end
end
