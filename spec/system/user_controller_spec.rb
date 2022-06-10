require 'rails_helper'

RSpec.describe 'Userコントローラーのテスト', type: :controller do
# TODO: type: systemだとエラーになるのはなぜ？
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
  			expect(current_path).to eq user_path(user)
  		end

  		it '新規登録に失敗' do
  			fill_in 'user[name]', with: ''
  			fill_in 'user[email]', with: ''
  			fill_in 'user[password]', with: 123123
  			fill_in 'user[password_confirmation]', with: 123123
  			click_button '新規登録'
  			expect(page).to have_content 'error'
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
        it 'プロフィール画像が表示される' do
          visit user_path(user)
          expect(page).to have_css('.profile_image')
        end
        it '名前が表示される' do
          visit user_path(user)
          expect(page).to have_content(user.name)
        end
        it '編集リンクが表示される' do
          visit user_path(user)
          expect(page).to have_link '会員情報編集', href: edit_user_path(user)
        end
        it '投稿件数が表示される' do
          visit user_path(user)
          expect(page).to have_content(user.post.count)
        end
      end
    end
  end
end