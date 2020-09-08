#firstメソッドとlastメソッド
#Post.first / Post.last  モデル中のデータの1番最初のデータを取り出す　最後のデータを取り出す
#Post.all[0]のように配列の番号を指定することで全部のデータの中から番号のデータだけ取り出すことができる

class PostsController < ApplicationController
  def index
  	#orderメソッドを用いることで、投稿一覧を並び替える
  	#昇順（古い順）（:asc）と降順(新しい順)（:desc）
  	@posts = Post.all.order(create_at: :desc)
  end

  def show
  	@post = Post.find_by(id: params[:id])
  	#ハッシュを使用している。下と同義
  	#ハッシュのキーをidに指定、取ってくるバリューをパラメーターのidで取得
  	#@post = Post.find_by(:id => params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	# createアクションのviewがない
  	# 使わないからviewを用意していない
  	# 用意する代わりにredirec_toを使って代用
  	@post = Post.new(content: params[:content])
  	if @post.save
  		redirect_to "/posts/index"
  	end
  end
end
