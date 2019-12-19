class PagesController < ApplicationController
  include AmazonApi

  def index
    redirect_to games_path if logged_in?
    @games = popular_games
    @header = '最近人気のゲーム'
    end

  def search
    @games = search_results
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

  def search_results
    res = amazon_search(params[:search_word])
    res.items.map do |item|
      average = evaluation_average(item.get('ASIN'))
      game_info(
          CGI.unescapeHTML(item.get('ItemAttributes/Title')),
          item.get('LargeImage/URL'),
          CGI.unescapeHTML(item.get('ItemAttributes/Manufacturer')),
          Game.where(asin: item.get('ASIN')).count,
          average.nil? ? '-' : average)
    end
  end

  def game_info(title, image, manufacturer, count, average)
    {
        title: title,
        image: image,
        manufacturer: manufacturer,
        count: count,
        average: average
    }
  end

  def evaluation_average(asin)
    Game.where(asin: asin).average(:evaluation)
  end
end