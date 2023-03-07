require 'singleton'
require_relative 'router' #подключаем файл с классом Router

module Simpler
  class Application

    include Singleton

    def initialize
      @router = Router.new #создаем объект для хранения в нем всех маршрутов, переданных из config/routes.rb
    end


    def call(env)
      route = @router.router_for(env) #идем нужный нам маршрут. Метод router_for будет этим заниматься
      controller = route.controller.new(env) #route.controller выдасть нужный класс и мы создадим объект класса обработчика
      action = route.action #получаем название метода, который будет вызываться у обработчика
      make_response(controller, action) #генерируем rack-совместимый ответ 
    end

    def routes(&block)
      @router.instance_eval(&block) #instance_eval позволяет вызывать методы из блока (get, post) у @router, => @router должен иметь реализацияю этих блоков
    end

    private

    def make_response(controller, action)
      controller.make_response(action) 
    end

  end
end
