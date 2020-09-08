#firstメソッドとlastメソッド
#Post.first / Post.last  モデル中のデータの1番最初のデータを取り出す　最後のデータを取り出す

#Post.all[0]のように配列の番号を指定することで全部のデータの中から番号のデータだけ取り出すことができる

class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end
end
