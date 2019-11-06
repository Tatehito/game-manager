class PagesController < ApplicationController
  def index
    redirect_to profile_path if logged_in?
  end
end