module Simpler
  class Controller

    def initialize(env) 
     @request = Rack::Request.new(env) #объект запроса
     @response = Rack::Response.new # объект ответа
    end

    def make_response(action)
      [
        200,
        { 
          'Content-Type' => 'text/plain', 
          'X-Simpler-Action' => action,
          'X-Simpler-Controller' => self.class.name
         },
        ["Simpler framework in action!\n"]
      ]
    end

  end
end
