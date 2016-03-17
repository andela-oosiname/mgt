require "mgt/util"
module Mgt
  module Routing
    class Route
      attr_reader :controller_name, :request, :action
      def initialize(request, class_and_method)
        @controller_name, @action = class_and_method
        @request = request
      end

      def controller_class
        controller_name.to_constant
      end

      def dispatch
        controller = controller_class.new(request)
        response = controller.send(action)
        if controller.get_response
          controller.get_response
        else
          controller.render(action)
          controller.get_response
          # return [200, { "Content-Type" => "text/html" }, [response]]
        end
      end
    end
  end
end
