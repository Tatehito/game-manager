class PagesController < ApplicationController
  include AmazonApi

  def index
    redirect_to games_path if logged_in?
    @games = popular_games
    @header = '最近人気のゲーム'
    end

  def search
    @games = amazon_search(params[:search_word])
    @header = '検索結果'
    render 'index'
  end

  private

  def popular_games
    to = Time.now
    from = to - 1.month
    asin = Game.where(created_at: from...to).group(:asin).order("count_all DESC").limit(10).count

    asin.keys.map do |a|
      game = Game.find_by(asin: a)
      average = evaluation_average(a)
      game_info(
          game.title,
          game.image,
          game.manufacturer,
          Game.where(asin: a).count,
          average.nil? ? '-' : average)
    end
  end
end