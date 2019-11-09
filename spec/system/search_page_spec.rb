require 'rails_helper'

RSpec.describe "search page spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    click_link 'ログイン'
  end

  it 'is able to register unregistered games' do
    fill_in 'search_word', with: 'ドラゴンクエスト'
    click_on '検索'
    click_on '登録', match: :first
    expect(current_path).to eq games_path
    expect(page).to have_content 'Game was successfully registered.'
    expect(all('.title').size).to eq(1)
  end

  # it 'is not able to register registered games' do
  # end
end