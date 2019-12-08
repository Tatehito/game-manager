class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @years = current_user.games.pluck(:purchase_date).compact.map { | date | date.year }.sort.reverse
    @params = { status: params[:status], year: params[:year] }
    @games = set_games
    @shelf_label = set_shelf_label
    @total_price = @games.map(&:price).compact.sum.to_s(:delimited, delimiter: ',')
    @user = current_user
  end

  def show
  end

  def new
    @game = Game.new
  end

  def edit
    @user = current_user
  end

  def create
    @game = current_user.games.new(game_params)
    if @game.save!
      redirect_to "/games/#{@game.id}/edit", notice: "「#{@game.title}」を登録しました。"
    end
  end

  def update
    if @game.update(game_params)
      redirect_to edit_game_url, notice: '更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: "「#{@game.title}」を削除しました。"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:user_id, :asin, :url, :title, :manufacturer, :price, :image, :status, :platform, :evaluation, :memo, :play_time, :purchase_date)
  end

  def set_games
    games = current_user.games
    games = games.where(status: params[:status]) unless params[:status].nil?
    games = games.where(purchase_date: Range.new("#{params[:year]}-01-01", "#{params[:year]}-12-31")) unless params[:year].nil?
    return games
  end

  def set_shelf_label
    if(params[:status].nil?)
      if(params[:year].nil?)
        label = 'のゲーム棚'
      else
        label = "が#{params[:year]}年に購入したゲーム"
      end
    else
      status_name = Status.find(params[:status]).name
      if(params[:year].nil?)
        label = "の#{status_name}ゲーム"
      else
        label = "が#{params[:year]}年に購入した、#{status_name}ゲーム"
      end
    end
    current_user.user_name + 'さん' + label
  end
end
