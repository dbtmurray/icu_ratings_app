Ratings::Application.routes.draw do

  root to: "pages#home"

  %w[home my_home contacts overview system_info].each { |p| get p => "pages##{p}"}
  match "/their_home/:id" => "pages#their_home", as: "their_home"
  get "log_in"  => "sessions#new"
  get "log_out" => "sessions#destroy"

  resources :articles
  resources :downloads
  resources :federations,  only: [:index]
  resources :fide_players, only: [:index, :show, :update]
  resources :fide_ratings, only: [:index, :show]
  resources :icu_players,  only: [:index, :show] do
    get :graph, on: :member
  end
  resources :icu_ratings,  only: [:index, :show] do
    get :war, :juniors, :improvers, on: :collection
  end
  resources :players,      only: [:show]
  resources :sessions,     only: [:create]
  resources :tournaments,  only: [:index, :show]

  namespace "admin" do
    resources :events,              only: [:index, :show, :destroy]
    resources :failures,            only: [:index, :show, :destroy, :new]
    resources :fees,                only: [:index, :update]
    resources :fide_player_files,   only: [:index, :show, :new, :create, :destroy]
    resources :logins,              only: [:index]
    resources :new_players,         only: [:index]
    resources :old_players,         only: [:index, :show, :edit, :update]
    resources :old_ratings,         only: [:index]
    resources :old_rating_histories,only: [:index]
    resources :old_tournaments,     only: [:index]
    resources :players,             only: [:index, :show, :edit, :update, :destroy]
    resources :rating_lists,        only: [:index, :show, :edit, :update] { resources :publications, only: [:show, :create, :edit, :update] }
    resources :rating_runs,         only: [:index, :show, :create, :edit, :update, :destroy]
    resources :results,             only: [:new, :create, :edit, :update]
    resources :subscriptions,       only: [:index]
    resources :tournaments,         only: [:index, :show, :edit, :update, :destroy]
    resources :uploads,             only: [:index, :show, :new, :create, :destroy]
    resources :users,               only: [:index, :show, :edit, :update]
  end

  match "/news_items"     => redirect("/articles")
  match "/news_items/:id" => redirect("/articles/%{id}")

  match "*url" => "pages#not_found"
end
