Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :reward_pages, only: [:new]
  resources :reward_pages, except: [:new, :create, :index, :destroy], path: "s" do
    resources :tasks, only: [:new, :create, :destroy], controller: "reward_pages/tasks" do
      resource :approvals, only: [:create, :destroy], controller: "reward_pages/approve_tasks"
    end

    resources :participants, only: [:new, :create, :destroy], controller: "reward_pages/participants"
    resources :rewards, only: [:index, :new, :create, :destroy], controller: "reward_pages/rewards"
  end

  resources :participants, only: [:show], path: "p" do
    resources :tasks, only: [] do
      resource :complete, only: [:create, :destroy], controller: "participants/complete_tasks"
    end
    resources :rewards, only: [] do
      resources :redeem, only: [:create], controller: "participants/redeem_rewards"
    end
  end

  root to: "pages#index"
  get '/signature', to: 'pages#signature'
end
