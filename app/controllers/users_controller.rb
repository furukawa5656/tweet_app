class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name],
                     email: params[:email],
                     image_name: "default_user.jpg"
                     #ユーザー登録時に初期画像を自動で設定している
                     )
    if @user.save
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

  def destroy
  end
end
