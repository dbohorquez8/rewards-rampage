Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reward_pages, only: [:new]
  resources :reward_pages, except: [:new, :create, :index, :destroy], path: "s" do
    resources :tasks, only: [:new, :create, :destroy], controller: "reward_pages/tasks"
  end


  root to: "pages#index"
end
