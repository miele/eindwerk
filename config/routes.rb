Skarminkels::Application.routes.draw do

  get "succes/index"

  resource :facebook, :except => :create do
    get :callback, :to => :create
  end

  get "config_key/index"

  get "videos/index"

  get "gigs/index"

  get "backend/index"

  get "backend/subjects"

  get "promo/index"

  get "fb/index"

  resources :contacts

  resources :supports

  resources :albums
  resources :pictures
  
  resources :succes



  get "tracks/player"


  
  match "/download_pdf/:id/(.:format)" => 'contacts#index_pdf', :method => :get, :as=>:index_pdf

  
 #match "/application.manifest" => Rails::Offline
 
# separate the devise logic from the user crud
# devise has a prefix now example "localhost:3000/admin/users/sign_in"
  devise_for :users, :path_prefix => "/admin"
  
  #resources :tracks # takes care off the routes for responses/get calls
 resources :convert
 
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  get "testier/index"

  root :to => "subjects#top"
   

  #get "demo/index"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  
  match ':controller(/:action(/:id(.:format)))'
  #resources :users
  match '*a', :to => 'errors#routing'
end
