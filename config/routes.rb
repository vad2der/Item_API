Rails.application.routes.draw do
	namespace :api do
  		namespace :v1 do
  			resources :items, only: [:index, :show]
  			resources :item_by_seller, only: [:show]
  			resources :item_by_category, only: [:show]
  		end
  	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
