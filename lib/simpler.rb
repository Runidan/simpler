require 'pathname'
require_relative 'simpler/application'

#весь код фр.ворка храним в модуле Simpler
module Simpler

  class << self
    def application #возвращает объект приложения
      Application.instance
    end

    def root
      Pathname.new(File.expand_path('..', __dir__))
    end
  end

end
