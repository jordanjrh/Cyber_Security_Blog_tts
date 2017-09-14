Rails.application.routes.draw do

  resources :comments
  resources :posts
  devise_for :users


  root 'posts#index'

  get 'about' => 'static#about'

  get 'contact' => 'static#contact'

  get 'account' => 'static#account'

  get 'comments' => 'comments#index'




end
