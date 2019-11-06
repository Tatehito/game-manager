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
    # expect(page).to have_link 'ゲームメーター'

    # expect(page).to have_link 'テキストボックス'
    # expect(page).to have_link '検索'
    
    # プロフィールなど正しく表示されている

  end

  # it '集計値の確認' do
  # end

  # it ゲームソフト一覧画面を表示（ALL） do
  # end

  # it ゲームソフト一覧画面を表示（ステータスごと） do
  # end

  # it 'ゲームソフト一覧画面を表示（プラットフォームごと）' do
  # end

  # it 'Amazon検索' do
  #   fill_in 
  #   click_on '検索'
  #   expect(current_page).to eq ''
  #   検索結果が表示されること
  #   登録済みのゲームはボタンが非活性
  #   未登録のゲームは活性
  #   ページングの確認
  # end
end