Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"
  resources :reservation
  resources :inventory
  resources :laboratory

  match '*path', to: 'application#route_not_found',
                 via: :all,
                 as: 'route_not_found'
end
