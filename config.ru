require_relative 'config/environment' #файл, где описывается все, что необходимо для нашего приложения

run Simpler.application

# можно было подключить так:
# run Simpler::Application.instance
# но мы скрываем реализацию
