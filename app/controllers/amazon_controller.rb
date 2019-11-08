class AmazonController < ApplicationController
  require 'amazon/ecs'

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
          title: item.get('ItemAttributes/Title'),
          manufacturer: item.get('ItemAttributes/Manufacturer'),
          price: item.get('ItemAttributes/ListPrice/FormattedPrice'),
          image: item.get('LargeImage/URL')
      )
      @games << game
    end
  end
end
