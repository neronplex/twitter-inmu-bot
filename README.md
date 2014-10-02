twitter-inmu-bot
==========

「なんでもしますから！」に対して「ん？」と[淫夢ネタ](http://dic.nicovideo.jp/a/%E7%9C%9F%E5%A4%8F%E3%81%AE%E5%A4%9C%E3%81%AE%E6%B7%AB%E5%A4%A2)を返すだけのbotプログラムです。RubyとHerokuを使って構築しています。

実行環境
----------
* Ruby 2.0.0以上
* 必須gem
    * foreman
    * twitter ([sferik/twitter - GitHub](https://github.com/sferik/twitter))

インストレーション
----------
1. Herokuアプリケーション上の環境変数にTwitter APIのトークン・botオペレーターのTwitter User ID (integer)を格納します。
2. 必要に応じてbot.rb, Gemfile, Procfileをカスタマイズしてください。Gemfileを変更した場合は`bunble install`を忘れずに。
3. Herokuにデプロイしてお使いください。


使い方
----------
* APIから流れてくるオブジェクトを参照することで、様々なカスタマイズが可能です。APIの詳しい形式は[こちら](https://dev.twitter.com/)をご覧ください。
 
ライセンス
----------
Copyright &copy; 2014 暖簾 ([@neronplex](http://www.twitter.com/neronplex))
Licensed under the [Apache License, Version 2.0][Apache]
 [Apache]: http://www.apache.org/licenses/LICENSE-2.0