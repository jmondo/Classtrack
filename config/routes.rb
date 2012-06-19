Classtrack4::Application.routes.draw do
  devise_for :administrators

  resources :students
  resources :subscriptions, only: :destroy
  resources :semesters
  resources :courses, only: :index

  root to: "students#new"
end
