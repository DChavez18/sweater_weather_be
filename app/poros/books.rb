class Books
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books,
              :id,
              :type
              
  def initialize(location, forecast, total_books_found, books)
    @id ='null'
    @type = 'books'
    @destination = location
    @forecast = forecast
    @total_books_found = total_books_found
    @books = books
  end
end