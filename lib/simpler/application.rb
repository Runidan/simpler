require 'yaml'
require 'singleton'
require 'sequel'
require_relative 'router' #подключаем файл с классом Router
require_relative 'controller' #подключим класс controller

module Simpler
  class Application

    include Singleton

    attr_reader :db

    def initialize
      @router = Router.new #создаем объект для хранения в нем всех маршрутов, переданных из config/routes.rb
      @db = nil
    end

    def bootstrap! #метод загрузки нашего приложения
      setup_database #конфигурирование базы данных
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
    
    def setup_database
      database_config = YAML.load_file(Simpler.root.join('config/database.yml')) #считываем конфигурацию бд
      database_config['database'] = Simpler.root.join(database_config['database']) #перезаписываем путь к бд относительно корня нашего приложения

      @db = Sequel.connect(database_config)
    end
  end
end

