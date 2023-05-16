Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  get 'saml_login', to: "application#saml_login"
  post 'saml_callback', to: "application#saml_callback"
end
