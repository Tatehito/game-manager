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
  
    @results = []
    res.items.map do |item|
      result = {
        title: item.get('ItemAttributes/Title'),
        manufacturer: item.get('ItemAttributes/Manufacturer'),
        price: item.get('ItemAttributes/ListPrice/FormattedPrice'),
        image: item.get('LargeImage/URL'),
        url: item.get('DetailPageURL'),
        asin: item.get('ASIN')
      }
      @results << result
    end
  end
end
