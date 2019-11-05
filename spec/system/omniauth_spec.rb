require 'rails_helper'

RSpec.describe "omniauth spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    click_link 'ログイン'
  end

  describe 'omniauth' do
    it "is able login/logout correctly" do
      expect(current_path).to eq root_path
      expect(page).to have_link 'ログアウト'

      click_on 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_link 'ログイン'
    end
  end
end