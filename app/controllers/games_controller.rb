class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = params[:status].nil? ? current_user.games : current_user.games.where(status: params[:status])
    @total_price = @games.map { |game| game.price }.sum.to_s(:delimited, delimiter: ',')
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
      params.require(:game).permit(:user_id, :asin, :url, :title, :manufacturer, :price, :image, :status, :platform, :evaluation, :memo, :play_time)
    end
end
