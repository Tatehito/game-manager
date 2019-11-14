class PagesController < ApplicationController
  def index
    redirect_to games_path if logged_in?
  end
end