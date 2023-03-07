module Simpler
  class Router
    class Route

      def initialize(method, path, handler)
        @method = method
        @path = path
        @handler = handler
      end

    end
  end
end
