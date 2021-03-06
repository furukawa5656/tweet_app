#firstメソッドとlastメソッド
#Post.first / Post.last  モデル中のデータの1番最初のデータを取り出す　最後のデータを取り出す
#Post.all[0]のように配列の番号を指定することで全部のデータの中から番号のデータだけ取り出すことができる

class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
  	#orderメソッドを用いることで、投稿一覧を並び替える
  	#昇順（古い順）（:asc）と降順(新しい順)（:desc）
  	@posts = Post.all.order(create_at: :desc)
  end

  def show
    #ハッシュを使用している。下と同義
    #ハッシュのキーをidに指定、取ってくるバリューをパラメーターのidで取得
    #@post = Post.find_by(:id => params[:id])
  	@post = Post.find_by(id: params[:id])
    #post.rb記載のインスタンスメソッド
    @user = @post.user
#likesテーブルからデータの件数を取得するには、countメソッドを用います。
#countメソッドは配列の要素数を取得するメソッドですが、テーブルのデータ数を取得するためにも利用することができます。
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
  	@post = Post.new
  end

  def create
  	# createアクションのviewがない
  	# 使わないからviewを用意していない
  	# 用意する代わりにredirec_toを使って代用
  	@post = Post.new(content: params[:content],
                    #新規投稿作成時に、user_idの値をいれて保存
                     user_id: @current_user.id
                     )
  	if @post.save
  		flash[:notice] = "投稿を作成しました"
  		redirect_to "/posts/index"
  	else
  		#renderの場合はurlで呼び出さず("フォルダ名/ファイル名") で呼び出す
		#※ ファイル名の部分には拡張子（.html.erb）を書かなくても大丈夫です
  		render "posts/new"
  	end
  end

  def edit
  	@post = Post.find_by(id: params[:id])
  end

  def update
  	#まずは更新する投稿データをデータベースから取り出します
  	@post = Post.find_by(id: params[:id])
  	@post.content = params[:content]
  	#updateメソッドにするとハッシュでキーとバリューを設定すれば更新可能
  	#ルーティングをメソッドpatchに変更とhtmlのfor_tagのurlもメソッドpatchに変更必要
  	#if @post.update(content: params[:content])
  	if @post.save
  		flash[:notice] = "投稿を編集しました"
  		redirect_to "/posts/index"
  	else
  		render "posts/edit"
  	end
  end

  def destroy
  	@post = Post.find_by(id: params[:id])
  	@post.destroy
  	flash[:notice] = "投稿を削除しました"
  	redirect_to "/posts/index"
  end

  def ensure_correct_user
#投稿に紐づくユーザーと現在ログインしているユーザーが異なるかどうかを比べるために、
#postsコントローラ内に「ensure_correct_user」というメソッドを用意
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to "/posts/index"
    end
  end

end










