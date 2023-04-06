require 'singleton'
require_relative 'router' #подключаем файл с классом Router
require_relative 'controller' #подключим класс controller

module Simpler
  class Application

    include Singleton

    def initialize
      @router = Router.new #создаем объект для хранения в нем всех маршрутов, переданных из config/routes.rb
    end

    def bootstrap!
      require_app #подключаем приложение
      require_routes  #подключаем маршруты
    end

    def call(env)
      route = @router.route_for(env) #идем нужный нам маршрут. Метод route_for будет этим заниматься
      controller = route.controller.new(env) #route.controller выдасть нужный класс и мы создадим объект класса обработчика
      action = route.action #получаем название метода, который будет вызываться у обработчика
      make_response(controller, action) #генерируем rack-совместимый ответ 
    end

    def routes(&block)
      @router.instance_eval(&block) #instance_eval позволяет вызывать методы из блока (get, post) у @router, => @router должен иметь реализацияю этих блоков
    end

    private

    def make_response(controller, action)
      controller.make_response(action) #отвечат за формирование rack-совместимого ответа
    end

    def require_app
      Dir["#{Simpler.root}/app/**/*.rb"].each { |file| require file } #получаем массив всех файлов внутри каталога app и подключаем его
    end

    def require_routes
      require Simpler.root.join('config/routes') #подключаем маршруты. Метод root возращает путь до текущей дириктории приложения
    end
  end
end
