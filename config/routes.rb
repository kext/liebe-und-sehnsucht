Rails.application.routes.draw do
  root to: 'boards#index'

  get 'index', to: 'boards#index'
  get 'settings', to: 'settings#settings', as: 'settings'
  get 'login', to: 'users#login', as: 'login'
  get 'logout', to: 'users#logout', as: 'logout'
  get 'register', to: 'users#register', as: 'register'
  get 'board:id', to: 'boards#show', as: 'board'
  get 'board:id/newtopic', to: 'topics#create', as: 'new_topic'
  get 'topic:id(/page:page)', to: 'topics#show', as: 'topic'
  get 'topic:id/lastpage', to: 'topics#lastpage', as: 'topic_lastpage'
  get 'user:id', to: 'users#show', as: 'user'

  post 'login', to: 'users#login'
  post 'register', to: 'users#register'
  post 'settings', to: 'settings#settings'
  post 'board:id/newtopic', to: 'topics#create'
  post 'topic:id(/page:page)', to: 'topics#show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
