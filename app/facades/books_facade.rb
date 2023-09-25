class BooksFacade
  def get_books(location, quantity)
    json = MapquestService.new.get_mapquest_data(location)
    data = json[:results][0][:locations][0][:latLng]
    city_coords = Mapquest.new(data)
    weather_data = WeatherService.new.get_weather_data(city_coords.lat, city_coords.lon)

    forecast = {
      summary: weather_data[:current][:condition][:text],
      temperature: weather_data[:current][:temp_f]
    }

    books_data = BooksService.new.get_books(location, quantity)

    books_results = books[:numFound]

    books_info = books[:docs].map do |book|
      {
        title: book[:title],
        publisher: book[:publisher],
        isbn: book[:isbn]
      }

    Books.new(books_info, forecast, books_results, location)
    end
  end 
end