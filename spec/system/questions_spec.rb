require 'rails_helper'

describe '質問投稿機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@user.com') }

  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@user.com') }

  let(:question_a) { FactoryBot.create(:question, title: '最初の質問', user: user_a) }

  before do
    FactoryBot.create(:question, title: '最初の質問', user: user_a)
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe '一覧表示機能' do
    context 'ユーザーがAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初の質問'
      end
    end

    context 'ユーザーがBログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初の質問'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーがAがログインしているとき' do
      let(:login_user) { user_a }
      before { visit question_path(question_a) }
      it 'ユーザーAが作成した質問が表示される' do
        expect(page).to have_content '最初の質問'
      end
    end
  end
end
