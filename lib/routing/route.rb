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
        controller.send(action)
        controller.render(action) unless controller.get_response
        controller.get_response
      end
    end
  end
end
