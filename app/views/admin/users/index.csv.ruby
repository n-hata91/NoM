require 'csv'
CSV.generate do |csv|
  header = %w(id ユーザー名 メールアドレス 登録日 学習言語 レベル)
  csv << header
  @users.each do |user|
    values = [user.id, user.name, user.email, user.created_at.to_s(:datetime_jp), user.language, user.level]
    csv << values
  end
end
