Rails.application.routes.draw do
  root to: "projects/projects#index"

  namespace :projects do
    resources :projects, only: [:new, :create, :index, :show]
  end
end
