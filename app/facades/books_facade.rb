class BooksFacade
  def get_books(location, limit)
    json = MapquestService.new.get_mapquest_data(location)
    data = json[:results][0][:locations][0][:latLng]
    city_coords = Mapquest.new(data)
    weather_data = WeatherService.new.get_weather_data(city_coords.lat, city_coords.lon)

    destination = location

    forecast = 
     {
      summary: weather_data[:current][:condition][:text],
      temperature: "#{weather_data[:current][:temp_f]} F"
     }

    books = BooksService.new.get_books(location, limit)
    
    total_books_found = books[:numFound]

    books_info = books[:docs].map do |book|
      {
        title: book[:title],
        publisher: book[:publisher],
        isbn: book[:isbn]
      }
    end
    
    Books.new(location, forecast, total_books_found, books_info)
  end
end