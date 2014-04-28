IuguSubscriptionExample::Application.routes.draw do
  root :to => 'index#index'

  devise_for :users

  as :user do
    get 'login' => 'devise/sessions#new', :as => 'new_user_session'
    post 'login' => 'devise/sessions#create', :as => 'user_session'
    delete 'logout' => 'devise/sessions#destroy', :as => 'destroy_user_session' 
    get 'logout' => 'devise/sessions#destroy', :as => 'destroy_user_session' 

    get 'signup' => 'devise/registrations#new', :as => 'new_user_registration'
    post 'signup' => 'devise/registrations#create', :as => 'user_registration'

    post 'forgot_password' => 'devise/passwords#create', :as => 'user_password'
    get 'forgot_password' => 'devise/passwords#new', :as => 'new_user_password'
    get 'forgot_password/edit' => 'devise/passwords#edit', :as => 'edit_user_password'
    put 'forgot_password' => 'devise/passwords#update', :as => 'update_user_pasword'
  end

  get 'subscribe' => 'subscription#subscribe', as: 'subscribe'
  post 'subscribe' => 'subscription#subscribe_to_plan', as: 'subscribe_to_plan'
  get 'a' => 'app#home', as: 'app_home'

  get 'profile' => 'profile#view', as: 'profile'
  get 'profile/new_payment_method' => 'profile#new_payment_method', as: 'profile_new_payment_method'
  post 'profile/create_payment_method' => 'profile#create_payment_method', as: 'profile_create_payment_method'
  delete 'profile/delete_payment_method/:id' => 'profile#delete_payment_method', as: 'profile_delete_payment_method'
  post 'profile/default_payment_method/:id' => 'profile#default_payment_method', as: 'profile_default_payment_method'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
