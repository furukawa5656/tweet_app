class User < ApplicationRecord
#bcryptをインストールすると、has_secure_passwordというメソッドが使えるようになる。
#has_secure_passwordを追加します。こうすることで、ユーザーを保存する際に自動的にパスワードを暗号化してくれます。
#has_secure_passwordはpassword_digestカラムにパスワードを保存することになっている。
#password_digestカラムに暗号化されたパスワードを保存するためには、今まで通りpasswordに値を代入します。
#こうすることで、has_secure_passwordによってpasswordに代入された値が暗号化され、password_digestカラムに保存されます。
#このため、既にあるpasswordに関するコードを変更する必要はありません。
#authenticateメソッドはパスワードを認証するためのメソッドで,
#正しいパスワードを入力するとtrueを返し、間違ったパスワードを入力するとfalseを返します。
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true,
					  uniqueness: true
					  #重複がないかをチェック

	def posts
		#whereは複数のデータを探す場合に使う。1個だけしかデータがないことが確定しているならfind_byで可
		return Post.where(user_id: self.id)
	end
end
