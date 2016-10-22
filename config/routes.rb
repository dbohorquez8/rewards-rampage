Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reward_pages, only: [:new]
  resources :reward_pages, except: [:new, :create, :index, :destroy], path: "s" do
    resources :tasks, only: [:new, :create, :destroy], controller: "reward_pages/tasks"
    resources :participants, only: [:new, :create, :destroy], controller: "reward_pages/participants"
  end

  resources :participants, only: [:show], path: "p" do
    resources :tasks, only: [] do
      resource :complete, only: [:create, :destroy], controller: "participants/complete_tasks"
    end
    resources :redeem_prize, only: [:create], controller: "participants/redeem_awards"
  end

  root to: "pages#index"
end
