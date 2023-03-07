require_relative 'router/route'

module Simpler
  class Router
    def initialize
      @routes = [] #в этом массиве мы будем хранить хеши с информацией кто и какой запрос будет обрабатывать 
    end

    def get(path, route_point)
      add_route(:get, path, route_point)
    end

    def post(path, route_point)
      add_route(:post, path, route_point)
    end

    private

    def add_route(method, path, route_point)
      route = Route.new(method, path, route_point) #создаем новый маршрут

      @routes.push(route) #добавляем маршрут в коллекцию
    end
  end
end
