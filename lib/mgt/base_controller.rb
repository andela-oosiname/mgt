require "tilt"

module Mgt
  class BaseController
    attr_reader :request
    def initialize(env)
      @request = Rack::Request.new(env)
    end

    def params
      request.params
    end

    def response(body, status = 200, header={})
      @response = Rack::Response.new(body, status, header)
    end

    def get_response
      @response
    end

    def render(*args)
      response(render_template(*args))
    end

    def render_template(view_name, locals = {})
      template = Tilt::ERBTemplate.new(File.join("app", "views", controller_name, "#{view_name}.html.erb"))
      template.render(self, locals.merge(get_instance_variables))
    end

    def get_instance_variables
      vars = {}
      instance_variables.each do |var|
        key = var.to_s.gsub("@","").to_sym
        vars[key] = instance_variable_get(var)
      end
      vars
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end
  end
end
