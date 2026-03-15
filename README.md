# Todo App

Ruby on Rails 製のシンプルな Todo 管理アプリケーションです。ユーザー認証機能を備え、優先度・期限・完了状態によるフィルタリング・ソートをサポートします。

## 機能

- ユーザー登録・ログイン（Devise）
- Todo の作成・編集・削除・詳細表示
- 優先度設定（低・中・高）
- 期限日設定
- 完了 / 未完了トグル（Turbo Stream によるリアルタイム更新）
- フィルタリング：未完了 / 完了 / 期限切れ
- ソート：作成日 / 期限日 / 優先度

## 技術スタック

| 項目 | バージョン |
|------|-----------|
| Ruby on Rails | ~> 8.1.2 |
| Ruby | (`.ruby-version` 参照) |
| データベース | SQLite3 |
| 認証 | Devise |
| フロントエンド | Hotwire (Turbo + Stimulus) |

## セットアップ

```bash
# 依存関係のインストール
bundle install

# データベースの作成・マイグレーション
bin/rails db:create db:migrate

# サーバー起動
bin/rails server
```

ブラウザで `http://localhost:3000` にアクセスしてください。

## Docker を使う場合

```bash
docker build -t todo_app .
docker run -p 3000:3000 todo_app
```

## テストの実行

```bash
bin/rails test
```

## デプロイ

[Kamal](https://kamal-deploy.org/) を使ったデプロイに対応しています。

```bash
bin/kamal deploy
```
