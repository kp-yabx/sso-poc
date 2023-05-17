Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  scope :saml do
    get 'metadata', to: "saml#metadata"
    get 'login', to: "saml#login", as: "saml_login"
    post 'callback', to: "saml#callback"
  end
end
