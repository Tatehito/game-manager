class PagesController < ApplicationController
  def index
    redirect_to games_path if logged_in?

    to = Time.now
    from = to - 1.month
    asin = Game.where(created_at: from...to).group(:asin).order("count_all DESC").limit(5).count

    @popular_games = asin.keys.map do |a|
      game = Game.find_by(asin: a)
      average = Game.where(asin: a).average(:evaluation)
      average = average.nil? ? '-' : average
      {
        # TODO 編集後のタイトルが表示されてしまう
        title: game.title,
        image: game.image,
        manufacturer: game.manufacturer,
        count: Game.where(asin: a).count,
        average: average
      }
    end
  end
end