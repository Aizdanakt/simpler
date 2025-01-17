module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @path_pattern = path_pattern(path)
      end

      def match?(env, path)
        match = path.match(@path_pattern)
        return false unless match

        params(env, match)
      end

      private

      def params(env, match)
        @params = match.named_captures.transform_keys(&:to_sym)
        env['simpler.params'] = @params
      end

      def path_pattern(path)
        Regexp.new("^#{path.gsub(/:([\w_]+)/, '(?<\1>[^\/]+)')}$")
      end

    end
  end
end
