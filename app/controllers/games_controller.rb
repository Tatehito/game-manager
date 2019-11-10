class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = params[:status].nil? ? current_user.games : current_user.games.where(status: params[:status])
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  def create
    @game = current_user.games.new(game_params)
    if @game.save!
      redirect_to games_url, notice: 'Game was successfully registered.'
    end
  end

  def update
    if @game.update(game_params)
      redirect_to edit_game_url, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
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
