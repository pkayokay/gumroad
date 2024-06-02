Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'pages#index'

  post '/subscribe', to: "pages#subscribe"
  post '/purchase/:product_id', to: "pages#purchase", as: :purchase
  get "/profile/:username", to: "pages#profile", as: :profile
  get "/profile/:username/p/:product_slug", to: "pages#product", as: :product_page
  get "/profile/:username/p/:product_slug/checkout", to: "pages#product_checkout", as: :product_checkout

  scope path: 'app' do
    get "/", to: "admin#dashboard", as: :admin
    get "/library", to: "admin#library", as: :library
    get "/emails", to: "admin#emails", as: :emails
    get "/products", to: "products#index"
    get "/followers", to: "followers#index"
    get "/settings", to: "settings#index"
    patch "/update_settings", to: "settings#update"

    resources :products, only: [:new, :edit, :update, :destroy] do
      collection do
        post "/", to: "products#create", as: :create
      end
    end
    resources :posts, only: [:new, :create]

    get "/library/:purchase_id", to: "purchases#show", as: :purchase_library
  end

  get "sign_in", to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete "sign_out", to: "sessions#destroy"
end
