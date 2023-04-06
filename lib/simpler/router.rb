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

    def route_for(env) #метод, который возвращает нужный route из router
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']

      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, route_point)
      route_point = route_point.split('#') 
      controller = controller_from_string(route_point[0]) #получаем контроллер (Класс)
      action = route_point[1] #Название экшена
      route = Route.new(method, path, controller, action) #создаем новый маршрут

      @routes.push(route) #добавляем маршрут в коллекцию
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller") #const_get получает строку, а возращает констранту
    end
  end
end
