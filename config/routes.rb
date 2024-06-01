Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'pages#index'

  get "/profile/:username", to: "pages#profile", as: :profile
  get "/profile/:username/p/:product_slug", to: "pages#product", as: :product_page

  scope path: 'app' do
    get "/", to: "admin#dashboard", as: :admin
    get "/products", to: "products#index"
    get "/settings", to: "settings#index"
    patch "/update_settings", to: "settings#update"
  end

  resources :products, only: [:new, :edit, :update, :destroy] do
    collection do
      post "/", to: "products#create", as: :create
    end
  end

  get "sign_in", to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete "sign_out", to: "sessions#destroy"
end
