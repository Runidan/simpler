require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      #прочитаем шаблон как есть
      template = File.read(template_path) #отрендерить означает прочитать. Теперь нужно построить путь к данному файлу. 
      #отправим его интерпритатору
      ERB.new(template).result(binding) #result возращает обработанный шаблон
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb") #join объеденит все аргументы через /
    end

    def template
      @env['simpler.template']
    end
  end
end