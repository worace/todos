Rails.application.routes.draw do
  root to: "lists#index"
  get "/lists/:id/download", to: "lists#download", as: "download_list"
  post "/lists/:id/upload", to: "lists#upload", as: "upload_list"
  resources :lists do
    post "archive" => "lists#archive"
    resources :tasks
  end
  resources :archived_lists, only: [:index, :create]
  resources :completed_tasks, only: [:create]
end
