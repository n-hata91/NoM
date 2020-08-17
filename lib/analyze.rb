require 'base64'
require 'json'
require 'net/https'
module Analyze
  class << self
    def get_data(text)
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=#{ENV['GOOGLE_NATURAL_LANGUAGE_API_KEY']}"
      params = { # APIリクエスト用のJSONパラメータ
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      uri = URI.parse(api_url) # Google Cloud Natural Language APIにリクエスト
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      JSON.parse(response.body)['documentSentiment']['score'] # APIレスポンス出力
    end
  end
end