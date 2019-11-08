require 'rails_helper'

RSpec.describe "user page spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    click_link 'ログイン'
  end

  it 'has correct links and contents' do
    expect(page).to have_link 'ログアウト'
    expect(page).to have_link 'ゲームメーター', href: root_path
    
    # ユーザー名
    # Twitterアカウント
    # Twitterプロフィール画像
  end

  # describe '集計値の確認' do
  # end

  # it ゲームソフト一覧画面を表示（ALL） do
    # click_on '全ソフト'
    # expect(current_path).to eq games_path
    # そのユーザーの全ソフトが表示されていること
    # ページングまたぎ
  # end

  # it ゲームソフト一覧画面を表示（ステータスごと） do
  # end

  describe 'search by Amazon' do
    it 'display search results' do
      fill_in 'search_word', with: 'ドラゴンクエスト'
      click_on '検索'
      expect(current_path).to eq search_path
      expect(all('.title').size).to eq(10)
      expect(page).to have_button '登録'
    end

    it '空欄で検索した場合'
    it '検索結果ゼロ件の場合'
    it '登録済みのゲームはボタンが非活性'
    it '未登録のゲームは活性'
  end
end