require_relative 'view'

module Simpler
  class Controller

    attr_reader :name

    def initialize(env) 
      @name = extract_name
      @request = Rack::Request.new(env) #объект запроса
      @response = Rack::Response.new # объект ответа
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers #устанавливаем дефолтные заголовки
      send(action) #вызываем экшн у текущего объекта(исполняем тот код, который прописан акшене пользовательского контроллера)
      write_response

      @response.finish # возращает ответ. По умолчанию => [200, {}, []]
    end

    private

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body #формируем тело ответа

      @response.write(body) #записываем тело ответа в ответ
    end

    def render_body #формирует тело ответа
      View.new(@request.env).render(binding)
    end

    def extract_name
      #Получаем имя класса текущего объекта с помощью регулярного выражения
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def render(template)
      @request.env['simpler.template'] = template
    end
  end
end
