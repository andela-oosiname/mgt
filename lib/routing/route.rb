require "mgt/util"
module Mgt
  module Routing
    class Route
      attr_reader :controller_name, :request, :action
      def initialize(request, class_and_method)
        @controller_name, @action = class_and_method
        @request = request
      end

      def controller
        controller_name.to_constant
      end

      def dispatch
        controller.new(request).send(action)
      end
    end
  end
end
