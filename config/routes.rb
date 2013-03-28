Up2u::Application.routes.draw do
  root to: "areas#index"
  resources :areas, only: [:index, :show]
end
