class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :edit, :update]
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name],
                     email: params[:email],
                     #ユーザー登録時に初期画像を自動で設定している
                     image_name: "default_user.jpg",
                     password: params[:password]
                     )
    if @user.save
#ユーザー登録が成功した時に、作成したユーザーがそのままログイン状態になるようにしましょう。
#usersコントローラのcreateアクション内で作成したユーザーのidをsession[:user_id]に代入しましょう。
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to "/users/#{@user.id}"
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      #受け取った画像データを保存（画像データを元に画像ファイルを作成）する)(画像の場合はしないといけない)
      #画像ファイル生成のためにFileクラス.binwriteメソッドを使用
      #ファイルの場所,ファイルの中身(readメソッドを使うことで画像データを取得)
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to "/users/#{@user.id}"
    else
      render :edit
    end
  end

  def login_form
  end

  def login
    #パラメーターで送れたてきたemailとpasswordでテーブルの中からuserを見つけてくる
    #また、テーブルの中にemailとpasswordで該当するuserがいればログイン、いなければログインできない条件分岐
    @user = User.find_by(email: params[:email],
                          password: params[:password])
    if @user
      #user_idをキーとし、値を代入します。
      #@userが存在する場合に変数sessionに@user.idを代入することで、
      #特定したログインユーザーの情報が保持され続けます。
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/posts/index"
    else
      #renderメソッドによってログインページが再表示されたときに、直前に入力したメールアドレスとパスワードが初期値としてセット
      @email = params[:email]
      @password = params[:password]
      #今回のエラーメッセージはバリデーションのエラーメッセージとは異なり、「find_byメソッドで検索したが存在しなかった」という結果を伝えるためのも
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end

  def ensure_correct_user
#ログイン中のユーザーのidと編集したいユーザーのidが等しいか判定します。
#ログイン中のユーザーのidは@current_user.idに、編集したいユーザーのidはparams[:id]にそれぞれ代入されています。
#しかし、params[:id]で取得できる値は文字列であり、数値である@current_user.idと比較してもfalseとなります。
#to_iメソッドを用いると、文字列を数値に変換することができます。to_iメソッドでparams[:id]を数値に変換し、@current_user.idと比較しましょう。
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to "/posts/index"
    end
  end

  def destroy
  end
end







