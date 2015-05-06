Rails.application.routes.draw do
  root to: "lists#index"
  resources :lists do
    post "archive" => "lists#archive"
  end
end
