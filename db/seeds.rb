# 開発用 会員
User.create!(
  name: '自分',
  email: 'hh@hh',
  image: open("./app/assets/images/no_image.jpg"),
  introduction: "#{ForgeryJa(:date).month}生まれ、#{ForgeryJa(:address).full_address}在住です。",
  level: 3,
  language: '英語',
  password: 'hhhhhhhh'
)
Admin.create!(
  email: 'hh@hh',
  password: 'hhhhhhhh'
)

# ユーザ情報
20.times do |n|
  name = ForgeryJa(:name).full_name
  email = ForgeryJa('email').address
  introduction = "#{ForgeryJa(:date).month}生まれ、#{ForgeryJa(:address).full_address}在住です。"
  level = rand(0..3)
  language = ['英語','スペイン語','フランス語','繁体中国語']
  password = 'password'
  date1 = Faker::Time.between(from: '2015-05-01', to: '2020-05-01')
  date2 = Faker::Time.between(from: '2020-08-02', to: '2020-08-15')
  User.create!(
    name: name,
    email: email,
    image: open("./app/assets/images/img#{rand(1..9)}.jpg"),
    introduction: introduction,
    level: level,
    language: language[rand(0..3)],
    password: password,
    created_at: date1,
    current_sign_in_at: date2
  )
end

# フォロー
User.all.each do |user|
  own_id = [user.id]
  follow_ids = (1..20).to_a.shuffle.take(rand(1..18)) - own_id
  follow_ids.each do |i|
    User.find(i).following << user
  end
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

  # タグ
Tag.create!(
  [
    { name: 'movie',
      score: Analyze.get_data('movie')},
    { name: 'tipcorn',
      score: Analyze.get_data('tipcorn')},
    { name: '面白い',
      score: Analyze.get_data('面白い')},
    { name: '勉強になる',
      score: Analyze.get_data('勉強になる')},
    { name: '感動',
      score: Analyze.get_data('感動')},
    { name: '旅行',
      score: Analyze.get_data('旅行')},
    { name: '絵がきれい',
      score: Analyze.get_data('絵がきれい')},
    { name: '微妙',
      score: Analyze.get_data('微妙')},
    { name: '少しだめ',
      score: Analyze.get_data('少しだめ')},
    { name: 'だめ',
      score: Analyze.get_data('だめ')},
    { name: 'bad',
      score: Analyze.get_data('bad')},
    { name: '時間の無駄',
      score: Analyze.get_data('時間の無駄')},
    { name: '最悪',
      score: Analyze.get_data('最悪')},
    { name: 'おすすめ',
      score: Analyze.get_data('おすすめ')},
    { name: '勉強法',
      score: Analyze.get_data('勉強法')},
    { name: '暗記',
      score: Analyze.get_data('暗記')},
    { name: 'かっこいい',
      score: Analyze.get_data('かっこいい')},
    { name: 'かわいい',
      score: Analyze.get_data('かわいい')},
    { name: '動物',
      score: Analyze.get_data('動物')},
    { name: 'ホラー',
      score: Analyze.get_data('ホラー')}
  ]
)

# 記事
10.times do |n|
  2.times do |m|
    user = User.find(rand(1..20))
    movie_id = rand(2..6)
    title = "【#{user.language}】#{Movie.find(movie_id).title}で勉強してみました。"
    content = "【#{user.language}】内容も良くて楽しみながら勉強できます。#{user.name}"
    rate1 = rand(3..5)
    rate2 = rand(3..5)
    rate3 = rand(3..5)
    rate4 = rand(3..5)
    rate5 = rand(3..5)
    rate = ((rate1 + rate2+ rate3 + rate4 + rate5)/5).round
    counter = rand(0..21)
    date = Faker::Time.between(from: '2020-07-01', to: '2020-08-01')
    user.articles.create!(
      movie_id: movie_id,
      title: title,
      content: content,
      rate: rate,
      difficulty: rate1,
      length: rate2,
      practicality: rate3,
      speed: rate4,
      accent: rate5,
      impressions_count: counter,
      created_at: date,
      score: Analyze.get_data(content)
    )
    Article.last.article_tags.create!(
      tag_id: 1
    )
    Article.last.article_tags.create!(
      tag_id: rand(3..18),
    )
  end
  2.times do |p|
    user = User.find(rand(1..20))
    movie_id = rand(2..6)
    title = "【#{user.language}】#{Movie.find(movie_id).title}で勉強してみました。"
    content = "【#{user.language}】内容が悪く勉強には向いていません。#{user.name}"
    rate1 = rand(1..3)
    rate2 = rand(1..3)
    rate3 = rand(1..3)
    rate4 = rand(1..3)
    rate5 = rand(1..3)
    rate = ((rate1 + rate2+ rate3 + rate4 + rate5)/5).round
    counter = rand(0..21)
    date = Faker::Time.between(from: '2020-07-01', to: '2020-08-01')
    user.articles.create!(
      movie_id: movie_id,
      title: title,
      content: content,
      rate: rate,
      difficulty: rate1,
      length: rate2,
      practicality: rate3,
      speed: rate4,
      accent: rate5,
      impressions_count: counter,
      created_at: date,
      score: Analyze.get_data(content)
    )
    Article.last.article_tags.create!(
      tag_id: 1
    )
    Article.last.article_tags.create!(
      tag_id: rand(3..18),
    )
  end
  user = User.find(rand(1..20))
    movie_id = 1
    title = "【tipcorn】こんな勉強しています。"
    content = "【#{user.language}】よかったら皆さんも試してみてください。#{user.name}"
    counter = rand(0..20)
    user.articles.create!(
      movie_id: movie_id,
      title: title,
      content: content,
      impressions_count: counter,
      image: open("./app/assets/images/pop#{rand(1..4)}.jpg"),
      score: Analyze.get_data(content)
    )
    Article.last.article_tags.create!(
      tag_id: 2
    )
    Article.last.article_tags.create!(
      tag_id: rand(3..18)
    )
end

# コメント
users = User.all[1..20]
users.each do |user|
  content = "[comment]#{user.name}のコメント。良いです。高評価"
  user.comments.create!(
    article_id: rand(1..30),
    content: content,
    score: Analyze.get_data(content)
  )
end
users2 = User.all[1..20]
users2.each do |user|
  content = "[comment]#{user.name}のコメントしました。悪いです。低評価"
  user.comments.create!(
    article_id: rand(1..30),
    content: content,
    score: Analyze.get_data(content)
  )
end

# 返信コメント
2.times do |n|
  users3 = User.all[1..20]
  users3.each do |user|
  content = "[reply]#{n}へ返信コメント。うれしい。ありがとう。"
  reply_to = rand(1..40)
  article = Comment.find(reply_to).article_id
  user.comments.create!(
    reply_to: reply_to,
    article_id: article,
    content: content,
    score: Analyze.get_data(content)
    )
  end
end

2.times do |n|
  users4 = User.all[1..20]
  users4.each do |user|
  content = "[reply]#{n}への返信コメント。ひどい。やめてください。"
  reply_to = rand(1..40)
  article = Comment.find(reply_to).article_id
  user.comments.create!(
    reply_to: reply_to,
    article_id: article,
    content: content,
    score: Analyze.get_data(content)
    )
  end
end

# 言語
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