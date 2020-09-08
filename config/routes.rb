Rails.application.routes.draw do

  #URLの部分は好きに変更可能です
  get "/" => "home#top"
  get "about" => "home#about"


  #「posts/:id」というルーティングは「posts/index」より下に書かなければいけません
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
end
