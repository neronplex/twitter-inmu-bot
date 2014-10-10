# coding: utf-8

# requires
require "twitter"

# 定数（中身は環境変数としてHerokuから受け取る）
OPERATOR_USERID    = ENV['TWITTER_OPERATOR_USERID'].to_i
CONSUMER_KEY       = ENV['TWITTER_CONSUMER_KEY']
CONSUMER_SECRET    = ENV['TWITTER_CONSUMER_SECRET']
OAUTH_TOKEN        = ENV['TWITTER_OAUTH_TOKEN']
OAUTH_TOKEN_SECRET = ENV['TWITTER_OAUTH_TOKEN_SECRET']

# REST APIの接続情報
client_rest = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end

# Streaming APIの接続情報
client_stream = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = CONSUMER_KEY
  config.consumer_secret     = CONSUMER_SECRET
  config.access_token        = OAUTH_TOKEN
  config.access_token_secret = OAUTH_TOKEN_SECRET
end

# Streaming APIのオブジェクトがここに流れてくる
client_stream.user do |object|
  # 流れてきたオブジェクトが指定されたクラス(Twitter::Tweet)であれば以下の処理を実行
  if object.is_a?(Twitter::Tweet)
    
    # 稼働テスト用
    if object.user.id == OPERATOR_USERID
      if object.text =~ /bot::test/
        #=> オペレーターからの "bot::test" という文字列が含まれているツイートに対して現在時刻を reply する
        client_rest.update("@#{object.user.screen_name} 稼働中 (#{Time.now})", options = {in_reply_to_status_id: object.id})
      end
    end
    
    # なんでもしますから！ -> ん？いまなんでもするって言ったよね？
    if object.text =~ /(なん|何)でもしますから[!！]/
      #=> オペレーターのツイートと "RT" の含まれているツイートは無視する
      if object.user.id == OPERATOR_USERID || object.text =~ /RT/i
      else
        #=> 「なんでもしますから！」という文字列が含まれているツイートに対して「ん？」と reply をする
        client_rest.update("@#{object.user.screen_name} ん？", options = {in_reply_to_status_id: object.id})
      end
    end
    
    # スミスニキロリコン用
    if object.user.id == '1237438117'.to_i && object.text =~ /(ロリ|幼女|小学生)/
      client_rest.update("@#{object.user.screen_name} またロリコンか、壊れるなあ・・・ #スミスニキやっぱり", options = {in_reply_to_status_id: object.id})
    end
    
  end
end