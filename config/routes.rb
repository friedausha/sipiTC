Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reservation, only: [:create,:update]
  match '*path', to: 'application#route_not_found',
                 via: :all,
                 as: 'route_not_found'
end
