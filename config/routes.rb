Rails.application.routes.draw do
  resources :contacts
  get 'contacts/index'
  root 'contacts#index'
end
