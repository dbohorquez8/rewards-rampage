Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reward_pages, only: [:new]
  resources :reward_pages, except: [:new, :create, :index, :destroy], path: "s"

  root to: "pages#index"
end
