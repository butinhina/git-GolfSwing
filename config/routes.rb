Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  root to: 'public/homes#top'
  devise_scope :customer do
    post 'public/guest_sign_in' => 'public/sessions#new_guest'
  end

  namespace :public do
    get '/about' => 'homes#about', as: 'about'
    get '/customers/:id' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'

    resources :post_videos do

      collection do
        get 'search'
        get 'confirm'
        get '/bookmarks' => 'bookmarks#index'
      end
      resource :bookmarks, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

  end
  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    root to: 'homes#top'
    get '/customers/:id' => 'customers#show'
    get '/customers/:id/edit' => 'customers#edit', as: 'customer_edit'
    patch '/customers/:id' => 'customers#update', as: 'customer_update'

    resources :post_comments, only: [:index, :destroy]
    resources :infomations, only: [:new,:create,:index,:edit,:update,:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
