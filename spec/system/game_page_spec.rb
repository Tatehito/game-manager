require 'rails_helper'

RSpec.describe "game page spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    click_link 'ログイン'
  end

  describe 'edit resistered game' do
    before do
      user = User.find_by(uid: OmniAuth.config.mock_auth[:twitter][:uid])
      user.games.create(
        asin: 'A000000001', status: '1', title: 'ほしいゲーム', image: 'https://dummy/images.jpg')
    end

    # it '全項目が正しく更新されること' do
      # 集計値が変わっていること
    # end

    it 'updates status to 今やってる form ほしい' do
      click_on 'ほしい'
      click_on 'ほしいゲーム', match: :first
      expect(page).to have_content('ほしいゲーム')
      expect(page).to have_select('Status', selected: 'ほしい')

      select '今やってる', from: 'Status'
      click_on '更新'
      expect(page).to have_content('Game was successfully updated.')
      expect(page).to have_select('Status', selected: '今やってる')
      
      click_on 'ゲームメーター'
      click_on 'ほしい'
      expect(all('.title').size).to eq(0)
      click_on 'ゲームメーター'
      click_on '今やってる'
      expect(all('.title').size).to eq(1)
    end
  end
end