class User < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true,
					  uniqueness: true
					  #重複がないかをチェック
	validates :password, presence: true
end
