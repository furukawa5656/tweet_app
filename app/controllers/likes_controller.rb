class LikesController < ApplicationController
	before_action :authenticate_user
  def create
  	#user_idは@current_userから
  	#post_idはparamsから取得(linkをクリックした時にルーティングでどのpostのidか記述している)
  	@like = Like.new(
  		user_id: @current_user.id,
  		post_id: params[:post_id]
  	)
  	@like.save
  	#post_idはparamsから取得
  	redirect_to "/posts/#{params[:post_id]}"
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to "/posts/#{params[:post_id]}"
  end
end
