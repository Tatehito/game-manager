module AmazonApi
  require 'amazon/ecs'

  def amazon_search(word)
    res = Amazon::Ecs.item_search(
        word,
        country: 'jp',
        response_group: 'ItemAttributes, Images',
        search_index: 'VideoGames'
    )

    res.items.map do |item|
      average = evaluation_average(item.get('ASIN'))
      game_info(
          CGI.unescapeHTML(item.get('ItemAttributes/Title')),
          item.get('LargeImage/URL'),
          CGI.unescapeHTML(item.get('ItemAttributes/Manufacturer')),
          Game.where(asin: item.get('ASIN')).count,
          average.nil? ? '-' : average)
    end
  end

  private

  def game_info(title, image, manufacturer, count, average)
    {
        title: title,
        image: image,
        manufacturer: manufacturer,
        count: count,
        average: average
    }
  end

  def evaluation_average(asin)
    Game.where(asin: asin).average(:evaluation)
  end
end