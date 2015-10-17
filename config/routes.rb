Rails.application.routes.draw do
  root 'cards#index'
  resources :cards do
    get 'delete'
  end

end
