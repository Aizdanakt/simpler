module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match(@path)
      end

      private

      def params?(path)
        match = path.match(@path)
        match ? match.named_captures.transform_keys(&:to_sym) : {}
      end

    end
  end
end
