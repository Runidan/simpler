#вызываем у экземпляра приложения метод routes в блоке передам маршруты
Simpler.application.routes do 
  get '/tests', 'tests#index'
  post '/tests', 'tests#create'
end
