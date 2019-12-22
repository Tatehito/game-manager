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
              title: title(item.get('ItemAttributes/Title')),
              manufacturer: manufacturer(item.get('ItemAttributes/Manufacturer')),
              image: image(item.get('LargeImage/URL')),
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

  def title(data)
    data.nil? ? 'タイトルなし' : CGI.unescapeHTML(data)
  end

  def manufacturer(data)
    data.nil? ? 'メーカー情報なし' : CGI.unescapeHTML(data)
  end

  def image(data)
    data.nil? ? '' : CGI.unescapeHTML(data)
  end
end