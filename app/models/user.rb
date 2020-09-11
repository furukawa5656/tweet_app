class User < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true,
					  uniqueness: true
					  #重複がないかをチェック
	validates :password, presence: true

	def posts
		#whereは複数のデータを探す場合に使う。1個だけしかデータがないことが確定しているならfind_byで可
		return Post.where(user_id: self.id)
	end
end
