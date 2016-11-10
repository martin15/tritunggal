Rails.application.routes.draw do

  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  resources :about_us, :only => [:index]
  resources :certificates, :only => [:index]
  resources :contact_us, :only => [:index, :create]
  get "products/search" => "products#search", :as => "product_search"
  get "products/:cat_permalink" => "products#index", :as => "products"
  get "products/:cat_permalink/:prod_permalink" => "products#show", :as => "product_detail"

  get "admin" => "admin/dashboard#index", :as => "admin"
  namespace :admin do
    resources :banners
    resources :categories
    resources :certificate_categories
    resources :certificates
    resources :clients
    get "product/products_by_category/:cat_permalink" => "products#products_by_category",
        :as => "products_by_category"
    get "contact_us_list" => "contact_us#index", :as => "contact_us_list"
    get "contact_us/:id" => "contact_us#show", :as => "contact_us"
    delete "contact_us/:id" => "contact_us#destroy", :as => "delete_contact_us"
    resources :products do
      member do
        resources :product_images, :param => :product_image_id
      end
    end
    resources :system_settings, :only => [:edit, :update]
  end

  root 'home#index'
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
