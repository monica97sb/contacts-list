Rails.application.routes.draw do
  resources :contacts
  root 'contacts#index'
  get 'contacts/index'
  get '/history', to: "contacts#history"
end
