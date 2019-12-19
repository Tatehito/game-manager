class SearchController < ApplicationController
  require 'cgi'
  include AmazonApi

  def index
    @games = amazon_search(params[:search_word])
  end
end
