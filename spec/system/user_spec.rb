require 'rails_helper'

RSpec.describe 'Userのテスト', type: :system do
  describe 'ユーザー認証のテスト' do
  	let!(:user) { create(:user) }
  	context '新規登録' do
  		before do
  			visit '/users/sign_up'
  		end

  		it '新規登録に成功' do
  			fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
  			fill_in 'user[email]', with: Faker::Internet.email
  			fill_in 'user[password]', with: user.password
  			fill_in 'user[password_confirmation]', with: user.password
  			click_button '新規登録'
  			expect(current_url).to eq current_url
  		end

  		it '新規登録に失敗' do
  			fill_in 'user[name]', with: ''
  			fill_in 'user[email]', with: ''
  			fill_in 'user[password]', with: 123123
  			fill_in 'user[password_confirmation]', with: 123123
  			click_button '新規登録'
  			expect(page).to have_content '保存されませんでした。'
  		end
  	end

  	context 'ログイン' do
      before do
        visit new_user_session_path
      end

      it 'ログインに成功する' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(current_path).to eq user_path(user)
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'ユーザーのテスト' do
    let(:user) { create(:user) }
    let!(:test_user2) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    describe 'マイページのテスト' do
      context '表示の確認' do
        before do
          visit user_path(user)
        end

        it 'プロフィール画像が表示される' do
          expect(page).to have_css('.profile_image')
        end

        it '名前が表示される' do
          expect(page).to have_content(user.name)
        end

        it '編集リンクが表示される' do
          expect(page).to have_link 'ユーザー情報編集', href: edit_user_path(user)
        end

        it '投稿件数が表示される' do
          expect(page).to have_content(user.posts.count)
        end
      end
    end

    describe '編集ページのテスト' do
      context '自分の編集画面への遷移' do

        it '遷移できる' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
      end

      context '他人の編集画面への遷移' do

        it '遷移できない' do
          visit edit_user_path(test_user2)
          expect(current_path).to eq(posts_path)
        end
      end

      context '編集が成功する' do

        it '成功' do
          visit edit_user_path(user)
          click_button '変更内容を保存'
          expect(current_path).to eq(user_path(user))
        end
      end

      context '編集が失敗する' do

        it '失敗' do
          visit edit_user_path(user)
          fill_in 'user[name]', with: ''
          fill_in 'user[email]', with: ''
          click_button '変更内容を保存'
          expect(page).to have_content 'ユーザー名を入力してください'
          expect(page).to have_content 'メールアドレスを入力してください'
        end
      end

      context '退会' do

        it '退会リンクのリンク先が正しい' do
          visit edit_user_path(user)
          click_link '退会する'
          expect(current_path).to eq(confirm_path(user))
        end

        it '退会するリンク先が正しい' do
          visit confirm_path(user)
          click_link '退会する'
          expect(page.accept_confirm).to eq "本当に退会しますか？"
          expect(current_path).to eq(root_path)
        end

        it '退会しないリンク先が正しい' do
          visit confirm_path(user)
          click_link '退会しない'
          expect(current_path).to eq(user_path(user))
        end
      end

      context '表示の確認' do
        before do
          visit edit_user_path(user)
        end

        it 'プロフィール画像投稿フォームが表示される' do
           expect(page).to have_field 'user[profile_image]'
        end

        it '名前編集フォームに自分の名前が表示される' do
          expect(page).to have_field 'user[name]', with: user.name
        end

        it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
          expect(page).to have_field 'user[email]', with: user.email
        end
      end
    end

    describe 'ユーザー一覧のテスト' do
      context '表示の確認' do
        before do
          visit users_path
          find("a.sort_link").click
          sleep(5)
          find("a.sort_link").click
        end

        it 'ユーザーの画像が表示される' do
          expect(page).to have_css(".profile_image")
        end

        it '自分と他のユーザーの名前が表示される' do
          expect(page).to have_content(user.name)
          expect(page).to have_content(test_user2.name)
        end

        it '自分と他のユーザーのユーザーIDが表示される' do
          expect(page).to have_content(user.id)
          expect(page).to have_content(test_user2.id)
        end

        it 'フォロー数が表示される' do
          expect(page).to have_link (user.followings.count), href: user_followings_path(user)
        end

        it 'フォローワー数が表示される' do
          expect(page).to have_link (user.followers.count), href: user_followers_path(user)
        end
      end
    end

    describe '他人の詳細画面' do
      context '表示項目の確認' do
        before do
          visit user_path(test_user2)
        end

        it 'ユーザー情報編集リンクが表示されない' do
          expect(page).to have_no_link 'ユーザー情報編集', href: edit_user_path(test_user2)
        end

        it 'フォローボタンが表示される' do
          expect(page).to have_content('フォローする')
        end
      end
    end
  end
end