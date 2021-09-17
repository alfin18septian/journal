Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :user
      post 'authenticate', to: 'authentication#create'


      # get 'users', to: 'user#index'
      # post 'profile', to: 'user#show'
      # post 'signup', to: 'user#create'
      # put 'user/update', to: 'user#update'
      # delete 'user/delete', to: 'user#delete'
    end
  end
end
