Rails.application.routes.draw do
  root to: "lists#index"
  resources :lists do
    post "archive" => "lists#archive"
    resources :tasks
  end
  resources :archived_lists, only: [:index, :create]
  resources :completed_tasks, only: [:create]
end
