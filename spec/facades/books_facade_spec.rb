require "rails_helper"

RSpec.describe "Books Facade" do 
  describe "#get_books" do
    it "returns book data and forecast for a city" do
      VCR.use_cassette('books_facade') do
        books_facade = BooksFacade.new
        location = "denver,co"
        quantity = 5

        books_data = books_facade.get_books(location, quantity)

        expect(books_data).to be_a(Books)

        expect(books_data.destination).to eq(location)

        forecast = books_data.forecast
        expect(forecast).to be_a(Hash)
        expect(forecast[:summary]).to be_a(String)
        expect(forecast[:temperature]).to be_a(String)

        expect(books_data.total_books_found).to be_a(Integer)

        books_info = books_data.books
        expect(books_info).to be_an(Array)
        expect(books_info.size).to eq(quantity)

        if books_info.any?
          book = books_info.first
          expect(book).to have_key(:title)
          expect(book[:title]).to be_a(String)
          expect(book).to have_key(:publisher)
          expect(book[:publisher]).to be_an(Array)
          expect(book).to have_key(:isbn)
          expect(book[:isbn]).to be_an(Array)
        end
      end
    end
  end
end
