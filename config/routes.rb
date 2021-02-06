Rails.application.routes.draw do
  root to: 'application#home'
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :expenses
  resources :groups do
    member do
      post :demote_to_member
      post :promote_to_admin
    end
  end
end
