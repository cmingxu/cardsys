Cardsys::Application.routes.draw do |map|

  resources :catenas do
    member do
      get :change_status
    end
  end

  resources :vacations
  
  resources :orders do
    resources :order_items do
      collection do
        post :batch_update
      end
    end
    resources :balances do
      collection do 
        get :balanced
      end
    end
  end

  resources :book_records do
    collection do
      get   :complete_for_members
      get   :complete_member_infos
      get   :recalculate_court_amount
      get   :advanced_new
      post  :advanced_create
      get   :complete_for_member_card
    end
    member do
      get  :agent
      get  :cancle_agent
      post :do_agent
      get  :advanced_edit 
      post :advanced_update
    end
  end
  
  resources :advanced_orders do
    member do
      get :cancle
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  resources :members do
    collection do
      post :search
      get :granter_new
      get :granter_delete
      get :granter_edit
      get :granter_index
      get :granter_show
      get :member_card_index
      get :autocomplete_name
      get :get_members
      get :autocomplete_card_serial_num
      get :member_card_bind_index
      post :member_card_bind_update
      get :member_card_recharge
      get :member_card_freeze
      get :member_card_bind_list
      get :getMemberCardNo
    end
  end

  resources :cards do
    member do
      get :bind
      get :change_status
    end
  end

  resources :member_cards do
    collection do
      get :search
    end
  end
  resources :coaches
  resources :period_prices
  resources :common_resources do
    collection do
      get :common_resource_detail_index
      get :update_detail
      get :delete_detail
    end
    member do
      get :edit_detail      
    end
  end
  resources :courts do
    collection do
      get :court_status_search
      get :coach_status_search
      get :court_record_detail
      get :coach_record_detail
    end
     member do
      get :change_status
    end
  end
  resources :goods do
    collection do
      get :store_manage_index
      get :store_manage_update
      get :change_status
      get :autocomplete_name
      get :goods
      get :add_to_cart
    end
  end


  resource :account, :controller => "users"
  resources :users do
    collection do
      get :user_power_index
      get :user_power_update
    end
  end

  resource :user_session

  resources :departments do
    collection do
      get :department_power_index
      get :department_power_update
    end
  end
  
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  root :to => "members#index"
end