# 開発用 会員
User.create!(
  name: '自分',
  email: 'hh@hh',
  image: open("./app/assets/images/no_image.jpg"),
  introduction: "#{ForgeryJa(:date).month}生まれ、#{ForgeryJa(:address).full_address}在住です。",
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
    image: open("./app/assets/images/no_image.jpg"),
    introduction: introduction,
    level: level,
    language: language[rand(0..3)],
    password: password
  )
end

# 映画
Movie.create!(
  id: 1,
  title: 'tipcorn',
  overview: 'for tipcorn'
)

require 'net/http'
require 'uri'
require 'json'
  uri = URI.parse("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API_KEY']}&language=ja&query=%E3%82%A6%E3%82%A9%E3%83%BC%E3%83%AB&include_adult=false")
  json = Net::HTTP.get(uri)
  result = JSON.parse(json)
  jsonMovies = result["results"]
  jsonMovies.each do |movie|
    Movie.create!(
      title: movie["title"],
      overview: movie["overview"],
      image_id: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
    )
  end

# 記事
15.times do |n|
  2.times do |m|
    user = User.find(rand(1..15))
    movie_id = rand(2..6)
    title = "【#{user.language}】#{Movie.find(movie_id).title}は勉強になります。"
    content = "【#{user.language}】内容も良くて楽しみながら勉強できます。#{user.name}"
    rate1 = rand(1..5)
    rate2 = rand(1..5)
    rate3 = rand(1..5)
    rate4 = rand(1..5)
    rate5 = rand(1..5)
    rate = ((rate1 + rate2+ rate3 + rate4 + rate5)/5).round
    user.articles.create!(
      movie_id: movie_id,
      title: title,
      content: content,
      rate: rate,
      difficulty: rate1,
      length: rate2,
      practicality: rate3,
      speed: rate4,
      accent: rate5
    )
  end
  user = User.find(rand(1..15))
    movie_id = 1
    title = "【tipcorn】こんな勉強しています。"
    content = "【#{user.language}】よかったら皆さんも試してみてください。#{user.name}"
    user.articles.create!(
      movie_id: movie_id,
      title: title,
      content: content,
      image: open("./app/assets/images/pop#{rand(1..4)}.jpg")
    )
end

# コメント
3.times do |n|
  users = User.all[1..15]
  users.each do |user|
    content = "#{user.name}コメントしました。"
    user.comments.create!(
      article_id: rand(1..30),
      content: content,
    )
  end
end

# コメント
3.times do |n|
  users = User.all[1..15]
  users.each do |user|
  content = "#{n}への返信コメント"
  reply_to = rand(1..30)
  article = Comment.find(reply_to).article_id
  user.comments.create!(
    reply_to: reply_to,
    article_id: article,
    content: content
    )
  end
end

# タグ
Tag.create!(
  [
    { name: 'movie'},
    { name: 'tipcorn'},
  ]
)

# 言語（確定）
Language.create!(
  [
    { language:'英語' },
    { language:'スペイン語' },
    { language:'繁体中国語' },
    { language:'簡体中国語' },
    { language:'フランス語' },
    { language:'アラビア語' },
    { language:'ドイツ語' },
    { language:'イタリア語' },
    { language:'インドネシア語' },
    { language:'ポルトガル語' },
    { language:'韓国語' },
    { language:'トルコ語' },
    { language:'ロシア語' },
    { language:'オランダ語' },
    { language:'フィリピノ語' },
    { language:'ヒンディー語' },
    { language:'ノルウェー語' },
    { language:'スウェーデン語' },
    { language:'フィンランド語' },
    { language:'デンマーク語' },
    { language:'ポーランド語' },
    { language:'ハンガリー語' },
    { language:'タイ語' },
    { language:'ウクライナ語' },
    { language:'チェコ語' },
    { language:'ルーマニア語' },
    { language:'イギリス英語' },
    { language:'ベトナム語' },
  ]
)