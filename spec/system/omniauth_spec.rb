require 'rails_helper'

RSpec.describe "omniauth spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
  end

  it "is able login/logout correctly" do
    find(".ui.twitter.large.fluid.button").click #ログイン
    expect(current_path).to eq games_path
    expect(page).to have_link 'ログアウト'

    click_on 'ログアウト'
    expect(current_path).to eq root_path
    find(".ui.twitter.large.fluid.button").click #ログイン
  end

  it "redirect to profile page when logged-in user logs in" do
    find(".ui.twitter.large.fluid.button").click #ログイン
    expect(current_path).to eq games_path

    visit root_path
    expect(current_path).to eq games_path
  end
end