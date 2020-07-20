# 開発用 会員
User.create!(
  name: 'hh',
  email: 'hh@hh',
  level: 4,
  language: '英語',
  password: 'hhhhhh'
)

# ユーザ情報
15.times do |n|
  name = ForgeryJa(:name).full_name
  email = ForgeryJa('email').address
  introduction = "#{ForgeryJa(:date).month}生まれ、#{ForgeryJa(:address).full_address}在住です。"
  level = rand(1..5)
  language = ['英語','スペイン語','フランス語','中国語']
  password = 'password'
  User.create!(
    name: name,
    email: email,
    image_id: open("./app/assets/images/no_image.jpg"),
    introduction: introduction,
    level: level,
    language: language[rand(0..3)],
    password: password
  )
end

# 映画
5.times do |n|
  title = Faker::Movie.title
  content = Faker::Lorem.sentence
  Movie.create!(
    title: title,
    overview: content,
  )
end

# 記事
2.times do |n|
  users = User.all[1..15]
  users.each do |user|
    title = "【#{user.language}】おもしろい"
    content = "【#{user.language}】#{user.name}とても勉強になります。"
    rate = rand(1..5)
    user.articles.create!(
      movie_id: rand(1..4),
      title: title,
      content: content,
      rate: rate,
      difficulty: rate,
      length: rate,
      practicality: rate,
      speed: rate,
      accent: rate
    )
  end
end

# 言語（確定）
Language.create!(
  [
    { language:'フランス語' },
    { language:'英語' },
    { language:'アラビア語' },
    { language:'スペイン語' },
    { language:'ドイツ語' },
    { language:'イタリア語' },
    { language:'インドネシア語' },
    { language:'ポルトガル語' },
    { language:'韓国語' },
    { language:'トルコ語' },
    { language:'ロシア語' },
    { language:'オランダ語' },
    { language:'フィリピノ語' },
    { language:'マレー語' },
    { language:'繁体中国語' },
    { language:'簡体中国語' },
    { language:'ヒンディー語' },
    { language:'ノルウェー語' },
    { language:'スウェーデン語' },
    { language:'フィンランド語' },
    { language:'デンマーク語' },
    { language:'ポーランド語' },
    { language:'ハンガリー語' },
    { language:'ペルシア語' },
    { language:'ヘブライ語' },
    { language:'タイ語' },
    { language:'ウクライナ語' },
    { language:'チェコ語' },
    { language:'ルーマニア語' },
    { language:'イギリス英語' },
    { language:'ベトナム語' },
    { language:'ベンガル語' }
  ]
)