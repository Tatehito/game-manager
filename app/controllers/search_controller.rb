class SearchController < ApplicationController
  require 'cgi'
  include AmazonApi

  def index
    res = amazon_search(params[:search_word])

    @games = res.items.map do |item|
      Game.new(
          asin: item.get('ASIN'),
          url: item.get('DetailPageURL'),
          title: CGI.unescapeHTML(item.get('ItemAttributes/Title')),
          manufacturer: CGI.unescapeHTML(item.get('ItemAttributes/Manufacturer')),
          image: item.get('LargeImage/URL'),
          price: item.get('ItemAttributes/ListPrice/Amount')
      )
    end
  end
end
