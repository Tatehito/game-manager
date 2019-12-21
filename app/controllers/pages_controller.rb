class PagesController < ApplicationController
  include AmazonApi

  def index
    redirect_to games_path if logged_in?
    @games = popular_games
  end

  private

  def popular_games
    to = Time.now
    from = to - 1.month
    asin = Game.where(created_at: from...to).group(:asin).order("count_all DESC").limit(10).count

    asin.keys.map do |a|
      game = Game.find_by(asin: a)
      average = evaluation_average(a)
      {
          data: Game.new(
              asin: game.asin,
              url: game.url,
              title: game.title,
              manufacturer: game.manufacturer,
              image: game.image
          ),
          count: Game.where(asin: a).count,
          average: average.nil? ? '-' : average
      }
    end
  end
end