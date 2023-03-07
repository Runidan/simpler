module Simpler
  class Controller

    def initialize(env)
     
    end

    def make_response
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["Simpler framework in action!\n"]
      ]
    end

  end
end
