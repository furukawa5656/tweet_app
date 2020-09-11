class ApplicationController < ActionController::Base
	before_action :set_current_user

	def set_current_user
#session[:user_id]の値をもとに、ログイン中のユーザーの情報をデータベースから取得しましょう。
#find_byメソッドを用いてusersテーブルからidカラムの値がsession[:user_id]と等しいユーザーを取得し、変数に代入します。
#変数名は「現在のユーザー」という意味でcurrent_user
		@current_user = User.find_by(id: session[:user_id])
	end

#アクセス制限の処理を共通化します。authenticate_userは「ユーザーを認証する」という意味です。
#「現在ログイン中のユーザーが存在しない場合、ログインページにリダイレクトさせる」処理
	def authenticate_user
		if @current_user == nil
			flash[:notice] = "ログインが必要です"
			redirect_to "/login"
		end
	end

    def forbid_login_user
        if @current_user
	        flash[:notice] = "すでにログインしています"
	        redirect_to("/posts/index")
        end
    end

end
