module Mgt
  module Routing
    class Router
      attr_accessor :endpoints
      def draw(&block)
        instance_eval &block
        #find out the  difference between instance eval and yield
      end

      def root(to)
        get "/", to: to
      end

      def endpoints
        @endpoints ||= Hash.new { |hash, key| hash[key] = [] }
      end

      private

      def pattern(path)
        placeholders = []
        path.gsub!(/(:\w+)/) do |match|
          placeholders << match[1..-1].freeze
          "(?<#{placeholders.last}>[^/?#]+)"
        end
        [/^#{path}$/, placeholders]
      end

      def controller_and_action_for(path_to)
        controller_path, action = path_to.split("#")
        controller = "#{controller_path.capitalize}Controller"
        [controller, action.to_sym]
      end

      http_verbs = [:get, :post, :put, :patch, :delete]

      http_verbs.each do |method_name|
        define_method(method_name) do |path, to:|
          path = "/#{path}" unless path[0] = "/"
          klass_and_method = controller_and_action_for(to)
          @route_data = { path: path,
                          pattern: pattern(path),
                          klass_and_method: klass_and_method
                        }
          endpoints[method_name] << @route_data
        end
      end
    end
  end
end
