class AmazonController < ApplicationController
  require 'amazon/ecs'
  require 'cgi'

  def search
    # Amazon::Ecs::debug = true
    res = Amazon::Ecs.item_search(
      params[:search_word],
      country: 'jp',
      response_group: 'ItemAttributes, Images',
      search_index: 'VideoGames'
    )
  
    @games = []
    res.items.map do |item|
      game = Game.new(
          asin: item.get('ASIN'),
          url: item.get('DetailPageURL'),
          title: CGI.unescapeHTML(item.get('ItemAttributes/Title')),
          manufacturer: CGI.unescapeHTML(item.get('ItemAttributes/Manufacturer')),
          image: item.get('LargeImage/URL'),
          price: item.get('ItemAttributes/ListPrice/Amount')
      )
      @games << game
    end
  end
end
