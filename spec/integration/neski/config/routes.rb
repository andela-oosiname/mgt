NeskiApplication.routes.draw do
  root "todo#index"
  get "/todo", to: "todo#index"
  get "/todo/new", to: "todo#new"
  get "/todo/:id/edit", to: "todo#edit"
  post "/todo/:id", to: "todo#create"
  put "/todo/:id", to: "todo#update"
  patch "/todo/:id", to: "todo#update"
  delete "/todo/:id", to: "todo#destroy"
  get "/todo/:id", to: "todo#show"
end
