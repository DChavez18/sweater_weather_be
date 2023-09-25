require "rails_helper"

RSpec.describe "Books Service" do
  describe "instance methods" do
    it "returns book data, based on location" do
      books_service = BooksService.new
      books_data = books_service.get_books("denver,co", 5)

      expect(books_data).to be_a(Hash)
      expect(books_data).to have_key(:numFound)
      expect(books_data).to have_key(:docs)
      expect(books_data[:docs]).to be_an(Array)

      if books_data[:docs].any?
        book = books_data[:docs].first
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