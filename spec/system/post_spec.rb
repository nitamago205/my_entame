require 'rails_helper'

RSpec.describe 'Postのテスト', type: :system do
  let(:user) { create(:user) }
  let(:test_user2) { create(:user) }
  let(:genre) { create(:genre) }
  let!(:post) { create(:post, user_id: user.id, genre_id: genre.id) }
  let!(:user2_post) { create(:post, user_id: test_user2.id, genre_id: genre.id) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  describe '投稿のテスト' do
    context '新規投稿' do
      before do
        visit new_post_path
      end

      it '新規登録に成功' do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:20)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:100)
        select genre.genre_name, from: 'post[genre_id]'
        find('#star', visible: false).set(3.0)
        click_button '投稿する'
        expect(page).to have_content '新しく投稿しました。'
        expect(current_path).to eq post_path(Post.last)
      end

      it '新規登録に失敗' do
        fill_in 'post[title]', with: ''
        fill_in 'post[body]', with: ''
        click_button '投稿する'
        expect(page).to have_content 'を入力してください'
      end
    end
  end
  describe '投稿詳細画面のテスト', js: true do
    context '自分の投稿詳細画面の表示確認' do
      before do
        visit post_path(post)
      end

      it 'プロフィール画像が表示される' do
        expect(page).to have_css('.profile_image')
      end

      it '名前が表示される' do
        expect(page).to have_content(user.name)
      end

      it 'タイトルが表示される' do
        expect(page).to have_content(post.title)
      end

      it '本文が表示される' do
        expect(page).to have_content(post.body)
      end

      it 'ジャンル名が表示される' do
        expect(page).to have_content(genre.genre_name)
      end

      it 'いいね数が表示される' do
        expect(page).to have_content(post.favorites.count)
      end

      it 'コメント数が表示される' do
        expect(page).to have_content(post.post_comments.count)
      end

      it 'レートが表示される' do
        expect(page).to have_content(post.rate.to_i)
      end

      it '編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_post_path(post)
      end

      it '削除リンクが表示される' do
        expect(page).to have_link '削除', href: post_path(post)
      end
    end

    context '他人の投稿詳細画面の表示確認' do
      before do
        visit post_path(user2_post)
      end

      it '編集リンクが表示されない' do
        expect(page).to have_no_link '編集', href: edit_post_path(user2_post)
      end

      it '削除リンクが表示されない' do
        expect(page).to have_no_link '削除', href: post_path(user2_post)
      end
    end
  end

  describe '投稿編集画面のテスト' do
    context '自分の投稿編集画面への遷移' do

      it '遷移できる' do
        visit edit_post_path(post)
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end

    context '他人の投稿編集画面への遷移' do

      it '遷移できない' do
        visit edit_post_path(user2_post)
        expect(current_path).to eq(posts_path)
      end
    end

    context '編集が成功する' do

      it '成功' do
        visit edit_post_path(post)
        click_button '変更を保存'
        expect(current_path).to eq(post_path(post))
      end
    end

    context '編集が失敗する' do

      it '失敗' do
        visit edit_post_path(post)
        fill_in 'post[title]', with: ''
        fill_in 'post[body]', with: ''
        click_button '変更を保存'
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content '本文を入力してください'
      end
    end
  end

  describe '投稿削除のテスト' do
    before do
      visit post_path(post)
    end
    it '投稿削除' do
      click_link '削除'
      expect(page.accept_confirm).to eq "本当に消しますか？"
      expect(current_path).to eq(user_path(user))
    end
  end


end
