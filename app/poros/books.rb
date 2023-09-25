class Books
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books,
              :id,
              :type
  
  def initialize(books_info, forecast, books_results, location)
    @id = "null"
    @type = "books"
    @destination = location
    @forecast = forecast
    @total_books_found = books_info[:numFound]
    @books = books_results
  end
end