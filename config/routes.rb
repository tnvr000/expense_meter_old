Rails.application.routes.draw do
  root to: 'application#home'
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :expenses
  resources :tags
  resources :groups do
    member do
      post :demote_to_member
      post :promote_to_admin
      get :add_member
      post :remove_member
      post :make_member
      get :invitation
      post :accept_invitation
    end
  end

  resources :primary_categories do
    member do
      get :categories
    end
  end
end
