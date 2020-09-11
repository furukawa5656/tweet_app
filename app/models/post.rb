class Post < ApplicationRecord
	validates :content, presence: true,
						length: {maximum: 140}
	validates :user_id, {presence: true}

  def user
  	#インスタンスメソッド内で、selfはそのインスタンス自身を指す＝ここではPostモデル
    return User.find_by(id: self.user_id)
  end
end
