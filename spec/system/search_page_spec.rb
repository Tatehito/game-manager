require 'rails_helper'

RSpec.describe "search page spec", type: :system do
  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config['omniauth.auth'] = set_omniauth
    visit root_path
    find(".ui.twitter.large.fluid.button").click #ログイン
  end

  it 'is able to register game' do
    (all("#search_word")[1]).set("ドラゴンクエスト")
    (all(".wrapper-search-form")[0]).find("button").click #検索実行
    expect(page).to have_content '検索結果'
    expect(page).to_not have_content '検索結果はありません'

    (all("button")[3]).click #検索結果の一番上を登録
    expect(page).to have_content 'を登録しました。'

    visit root_path #一覧ページを表示
    expect(find(".game-list").all(".column").size).to eq(1)
  end
end