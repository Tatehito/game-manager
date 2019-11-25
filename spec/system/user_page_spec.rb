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

  describe 'display a list of registered games' do
    # context '2 pages' do
    # end
    
    context '1 page' do
      before do
        dummy_image = 'https://dummy/images.jpg'

        user = User.find_by(uid: OmniAuth.config.mock_auth[:twitter][:uid])
        user.games.create(
          asin: 'A000000001', status: '1', title: 'ほしいゲーム', image: dummy_image)
        user.games.create(
          asin: 'A000000002', status: '2', title: '今やってるゲーム', image: dummy_image)
        user.games.create(
          asin: 'A000000003', status: '3', title: 'クリア済のゲーム', image: dummy_image)
        user.games.create(
          asin: 'A000000004', status: '4', title: '積み', image: dummy_image)

        another_user = FactoryBot.build(:user, uid: 'another')
        another_user.save
        another_user.games.create(asin: 'A000000001', status: '1', title: 'ほしいゲーム', image: dummy_image)
      end

      it 'displays all game' do
        click_on '全ソフト'
        expect(current_path).to eq games_path
        expect(all('.title').size).to eq(4)
      end

      it 'displays game with status ほしい' do
        click_on 'ほしい'
        expect(current_path).to eq games_path
        expect(all('.title').size).to eq(1)
        expect(page).to have_content 'ほしいゲーム'
      end

      it 'displays game with status 今やってる' do
        click_on '今やってる'
        expect(current_path).to eq games_path
        expect(all('.title').size).to eq(1)
        expect(page).to have_content '今やってるゲーム'
      end

      it 'displays game with status クリア済' do
        click_on 'クリア済'
        expect(current_path).to eq games_path
        expect(all('.title').size).to eq(1)
        expect(page).to have_content 'クリア済のゲーム'
      end
      
      it 'displays game with status 積み' do
        click_on '積み'
        expect(current_path).to eq games_path
        expect(all('.title').size).to eq(1)
        expect(page).to have_content '積み'
      end
    end
  end

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