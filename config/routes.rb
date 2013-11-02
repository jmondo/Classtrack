Classtrack4::Application.routes.draw do
  devise_for :administrators
  mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'

  resources :students
  resources :subscriptions, only: :destroy
  resources :semesters
  resources :courses, only: :index

  root to: "students#new"
end
