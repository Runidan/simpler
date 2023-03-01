require 'singleton'

module Simpler
  class Application

    include Singleton


    def call(env)
      [
        200,
        { 'Content-Type' => 'text/plain' },
        ["Simpler framework in action\n"]
      ]
    end

    private

  end
end
