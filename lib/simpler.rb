require 'pathname'
require_relative 'simpler/application'

module Simpler

  class << self
    def application
      Application.instance
    end

    def root
      Pathname.new(File.expand_path('..', __dir__)) #оказываемся в корне проекта
    end
  end
end
