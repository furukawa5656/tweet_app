Rails.application.routes.draw do

  get "signup" => "users#new"
  get "users/index" => "users#index"
  #userを作ることは＝signup
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"
  delete "users/:id/destroy" => "users#destroy"

  #URLの部分は好きに変更可能です
  get "/" => "home#top"
  get "about" => "home#about"


  #「posts/:id」というルーティングは「posts/index」より下に書かなければいけません
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  #どの投稿の編集ページか判別するためにidが必要
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  delete "posts/:id/destroy" => "posts#destroy"
  get "posts/:id" => "posts#show"
end
