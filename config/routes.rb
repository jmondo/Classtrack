Classtrack4::Application.routes.draw do
  resources :students

  root to: "students#new"
end
