L33nkMe::Application.routes.draw do
  # default route
  root :to => 'home#index'
  
  get "home/index"
  
  # resource for urls
  resources :urls
  
  # route that sends you to a link
  match ":shorturl" => "urls#goto"

end
