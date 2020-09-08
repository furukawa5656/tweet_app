Rails.application.routes.draw do

  #URLの部分は好きに変更可能です
  get "/" => "home#top"
  get "about" => "home#about"

  get "posts/index" => "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
