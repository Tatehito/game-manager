require 'rails_helper'

RSpec.describe "user page spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    find(".ui.twitter.large.fluid.button").click #ログイン
  end

  describe 'display a list of registered games' do
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
      click_on 'すべて', match: :first
      expect(current_path).to eq games_path
      expect(find(".game-list").all(".column").size).to eq(4)
    end

    it 'displays game with status ほしい' do
      click_on 'ほしい'
      expect(current_path).to eq games_path
      expect(find(".game-list").all(".column").size).to eq(1)
      expect(page).to have_content 'Mock Userさんのほしいゲーム'
    end

    it 'displays game with status 今やってる' do
      click_on '今やってる'
      expect(current_path).to eq games_path
      expect(find(".game-list").all(".column").size).to eq(1)
      expect(page).to have_content 'Mock Userさんの今やってるゲーム'
    end

    it 'displays game with status クリア済' do
      click_on 'クリア済'
      expect(current_path).to eq games_path
      expect(find(".game-list").all(".column").size).to eq(1)
      expect(page).to have_content 'Mock Userさんのクリア済ゲーム'
    end
    
    it 'displays game with status 積み' do
      click_on '積み'
      expect(current_path).to eq games_path
      expect(find(".game-list").all(".column").size).to eq(1)
      expect(page).to have_content 'Mock Userさんの積みゲーム'
    end
  end
end