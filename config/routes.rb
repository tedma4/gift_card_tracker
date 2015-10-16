Rails.application.routes.draw do
  root 'cards#index'
  resources :cards
    get 'add_credit', to: 'cards#add_credit'

end
