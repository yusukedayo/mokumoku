# README

## 環境構築
```
$ bundle install --without=production
$ bin/rails db:setup
$ yarn install
$ bin/webpack
$ bin/rails s
```

## 事業をエンジニアリングしよう提案編の回答は以下に記述してください
```
選択した事業側の課題
直近一年間で、2回以上もくもく会に参加してくれた人は利用者全体の1%のみ。もくもく会で気の合う仲間を見つけられなかったのではないか？

提案内容
・もくもく会にタグ(Ruby, Rails, PHP, iOS, 駆け出しエンジニア etc)を設定 & 絞り込みができるようにする
→ 自分の学習している言語を見つけやすくする。また、人気のタグを表示することで、ユーザーは他の人々がどのようなトピックに関心を持っているかを知り、共通の興味を持つ仲間を見つけやすくなる。
・ユーザープロフィールに、ユーザーのタグ情報を追加する。
→　他のユーザーはプロフィールを見るだけで相手の興味を理解し、コミュニケーションをスムーズに始めることができる

実装方針
もくもく会でよく使用されるタグを抽出し、トレンドや人気のあるトピックを表示する機能を追加する。
ユーザープロフィールにおいて、タグを表示する機能を追加する。
```

