Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'pages#index'
  scope path: 'app' do
    get "/", to: "admin#dashboard", as: :admin
    get "/products", to: "products#index"
  end

  get "sign_in", to: "sessions#new"
  post 'sign_in', to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  delete "sign_out", to: "sessions#destroy"
end
