module AmazonApi
  require 'amazon/ecs'

  def amazon_search(word)
    Amazon::Ecs.item_search(
        word,
        country: 'jp',
        response_group: 'ItemAttributes, Images',
        search_index: 'VideoGames'
    )
  end
end