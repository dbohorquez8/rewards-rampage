require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks: (https://codahale.com/a-lesson-in-timing-attacks/)
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use `secure_compare` to stop length information leaking
    ActiveSupport::SecurityUtils.secure_compare(username, ENV["SIDEKIQ_USERNAME"]) &
      ActiveSupport::SecurityUtils.secure_compare(password, ENV["SIDEKIQ_PASSWORD"])
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"


  resources :reward_pages, only: [:new]
  resources :reward_pages, except: [:new, :create, :index, :destroy], path: "s" do
    put 'change_email', to: 'reward_pages#change_email'
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
