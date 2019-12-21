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
      {
          data: Game.new(
              asin: item.get('ASIN'),
              url: item.get('DetailPageURL'),
              title: CGI.unescapeHTML(item.get('ItemAttributes/Title')),
              manufacturer: CGI.unescapeHTML(item.get('ItemAttributes/Manufacturer')),
              image: item.get('LargeImage/URL'),
              price: item.get('ItemAttributes/ListPrice/Amount')
          ),
          count: Game.where(asin: item.get('ASIN')).count,
          average: average.nil? ? '-' : average
      }
    end
  end

  private

  def evaluation_average(asin)
    Game.where(asin: asin).average(:evaluation)
  end
end