class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(facebook google_oauth2)
  validates :name, presence: true, length: { in: 1..30 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 140 }
  attachment :image
  has_many :sns_credentials, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :follow_to, class_name: "Relation",
                       foreign_key: "follower_id",
                       dependent: :destroy
  has_many :follow_from, class_name: "Relation",
                         foreign_key: "followed_id",
                         dependent: :destroy
  has_many :following, through: :follow_to, source: :followed
  has_many :followers, through: :follow_from
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :article_tags, dependent: :destroy
  enum level: { '初心者レベル': 0, '初級会話レベル': 1, '日常会話レベル': 2, 'ビジネスレベル': 3 }

  # フォロー機能
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    follow_to.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # OAuth認証
  # ユーザーテーブルの中から、SNSからユーザーの情報を取得し、以前に登録されているか否かで条件分岐
  # callbackに渡すデータを選定する
  def self.find_oauth(auth)
    uid = auth.uid # SNS情報からuidを取り出す
    provider = auth.provider # SNS情報からproviderを取り出す
    snscredential = SnsCredential.where(uid: uid, provider: provider).first # 以前に登録していないか確認
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user] # 登録していたらそれを使って
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    { user: user, sns: sns }
  end

  # SnsCredentialに以前登録された記録がない場合
  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    if user.blank?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email,
      )
    end
    { user: user }
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
    { user: user, sns: sns }
  end

  # ランキング
  def self.post_ranking(num)
    find(Article.group(:user_id).order('count(user_id) desc').limit(num).pluck(:user_id))
  end

  def self.follower_ranking(num)
    User.find(Relation.group(:followed_id).order('count(followed_id) desc').limit(num).pluck(:followed_id))
  end
end