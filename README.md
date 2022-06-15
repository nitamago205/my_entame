# マイ・エンタメ

## サイト概要
<img width="718" alt="my_entame_image" src="https://user-images.githubusercontent.com/99108580/172554182-568a20ac-4004-4a38-959a-d001c0e583f9.png">

#### サイトURL https://myentame.com/
※ レスポンシブ対応している為、スマホからでもご確認頂けます。

### サイトテーマ
- アニメ、漫画、ゲーム、ドラマ、映画、テレビ番組、本、曲、様々なエンタメをレビューし、記録し、共有することができるサイト。

### テーマを選んだ理由
- アニメや漫画が好きで、レンタルをよく利用するのですが、何巻まで読んだか、何話まで見たか、分からなくなることがよくあり、記録しておきたいと思いました。
そしてその記録した作品をレビューし、共有できれば、自己紹介のツールとしても使えると考え、このテーマを選びました。

### ターゲットユーザ
- エンタメ好きな人

### 主な利用シーン
- エンタメを記録し、確認することができる。
- 自己紹介でレビューを見てもらい、趣味嗜好を知ってもらうことができる。
- 知り合いが新しく触れたエンタメを知ることができる。

## 使用技術
- Ruby 2.6.3
- Ruby on Rails 6.1.5.1
- MySQL 15.1
- Nginx
- Puma
- AWS
    - EC2
    - RDS
    - VPC
    - Route53
- RSpec
- Rubocop(リーダブルコード)

## 機能一覧
- 新規登録機能(devise)
- ログイン機能(devise)
- ゲストログイン機能
- アカウント退会機能(管理者＆自己のみ)
- アカウント削除機能(管理者のみ)
- 投稿機能
- レート機能(星5つで0.5刻みで評価)
- いいね機能(Ajax)
    - いいね数表示
- コメント機能(Ajax)
    - コメント数表示
- フォロー機能
- 検索機能(ransack)
    - 投稿タイトル検索
    - ユーザー名検索
- 絞り込み機能(ransack)
    - ジャンル別投稿一覧
    - いいねした投稿一覧
    - コメントした投稿一覧
- 並び替え機能(ransack)
    - 新しい順/古い順
    - レート順
    - いいね順
- ページネーション機能(kaminari)
- 通知機能
    - いいね通知
    - コメント通知
    - フォロー通知
    - 未読メッセージ通知
- レスポンシブ対応
    - スマホでも確認できます

### テスト
- [**テスト仕様書**](https://docs.google.com/spreadsheets/d/1qWFT5Y5v1nOheiFOOk85ZPNq4w_GPbFC/edit?usp=sharing&ouid=110514537080918976334&rtpof=true&sd=true)
- RSpec/factoryBot
    - 単体テスト(model)
    - 機能テスト(request)
    - 結合テスト(system)

## 設計書
- 画面遷移図（ユーザー側）
![マイ・エンタメ（画面遷移図、E-R図）-会員側 drawio](https://user-images.githubusercontent.com/99108580/173503457-35e827d2-bf61-4ee3-9bec-5d60a312386c.png)
- 画面遷移図（管理者側）
![マイ・エンタメ（画面遷移図、E-R図）-管理側 drawio](https://user-images.githubusercontent.com/99108580/172556203-45629c8b-2317-4173-a46e-9c2765a3de1d.png)
- E-R図
![マイ・エンタメ（画面遷移図、E-R図）-E-R図 drawio](https://user-images.githubusercontent.com/99108580/173503436-0b1b6b80-a91d-48e6-b72e-8e6e808e4b65.png)
- [**テーブル定義書**](https://docs.google.com/spreadsheets/d/1h_4w1nNzXQazNh-1fCNcwaOjVJf7ciCLhZBSscM9bxw/edit?usp=sharing)
- [**アプリケーション詳細設計書**](https://docs.google.com/spreadsheets/d/1Hah5XAJJVKxdDH7jzXfldODtVYThYdvfeUGHF_fn2Vo/edit?usp=sharing)

## 開発環境
- OS：Amazon Linux release 2 (Karoo)
- 言語：HTML,CSS,SCSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails,Bootstrap
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- [**イラストAC**](https://www.ac-illust.com/)
- [**Storyset**](https://storyset.com/)
- [**Tech Pic**](http://tech-pic.com/)
- [**Subtle Patterns**](https://www.toptal.com/designers/subtlepatterns/)

## 今後改善すべき点
- Rspecでのテストが少ない為、追加すること
- 問い合わせ機能の導入
- パスワード再設定機能の導入