require 'rails_helper'

RSpec.describe "game page spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    find(".ui.twitter.large.fluid.button").click #ログイン
  end

  describe 'edit resistered game' do
    before do
      user = User.find_by(uid: OmniAuth.config.mock_auth[:twitter][:uid])
      user.games.create(
        asin: 'A000000001', status: '1', title: 'ほしいゲーム', image: 'https://dummy/images.jpg')
    end

    it 'updates status to 今やってる form ほしい' do
      click_on 'ほしい'
      expect(find(".game-list").all(".column").size).to eq(1)
      
      find(".game-list").all(".column")[0].find("a").click
      expect(page).to have_content('ほしいゲーム')
      expect(page).to have_select('game_status', selected: 'ほしい')

      select '今やってる', from: 'game_status'
      click_on '更新'
      expect(page).to have_content('更新しました。')
      expect(page).to have_select('game_status', selected: '今やってる')
      
      visit root_path
      click_on 'ほしい'
      expect(find(".game-list").all(".column").size).to eq(0)

      visit root_path
      click_on '今やってる'
      expect(find(".game-list").all(".column").size).to eq(1)
    end
  end
end