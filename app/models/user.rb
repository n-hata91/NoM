class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  has_many :sns_credentials, dependent: :destroy
  has_many :articles, dependent: :destroy
  attachment :image

# ユーザーテーブルの中から、SNSからユーザーの情報を取得し、以前に登録されているか否かで条件分岐
# callbackに渡すデータを選定する
  def self.find_oauth(auth)
    uid = auth.uid #SNS情報からuidを取り出す
    provider = auth.provider　#SNS情報からproviderを取り出す
    snscredential = SnsCredential.where(uid: uid, provider: provider).first #以前に登録していないか確認
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user] #登録していたらそれを使って
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end

# SnsCredentialに以前登録された記録がない場合
  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
  end

# SnsCredentialに以前登録された記録がない場合
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        name: auth.info.name,
        email: auth.info.email,
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user ,sns: sns}
  end
end