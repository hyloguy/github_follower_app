Rails.application.routes.draw do

    root 'users#index'

    resources :users

    post 'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'

end
