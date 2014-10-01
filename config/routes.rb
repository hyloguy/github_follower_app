Rails.application.routes.draw do

    root 'users#index'

    resources :users

    # Login
    post 'sessions' => 'sessions#create'

    # Logout
    delete 'sessions' => 'sessions#destroy'

    get 'github' => 'github#begin'
    get 'github/code'
    post 'github/follow'

end
