require "rails_helper"

RSpec.describe Books do
  describe "instance methods" do
    it "exists" do
      books_data = Books.new("denver,co", {:summary=>"Sunny", :temperature=>80}, 80, [{:isbn=>["9780062457714", "0062457713"], :title=>"The Lord of the Rings", :publisher=>["testpublisher", "testpublisher2"]}])
      expect(books_data).to be_a(Books)
      expect(books_data.destination).to eq("denver,co")
      expect(books_data.forecast).to be_a(Hash)
      expect(books_data.forecast[:summary]).to eq("Sunny")
      expect(books_data.forecast[:temperature]).to eq(80)
      expect(books_data.total_books_found).to eq(80)
      expect(books_data.books).to be_an(Array)
      expect(books_data.books.size).to eq(1)
      expect(books_data.books.first).to be_a(Hash)
      expect(books_data.books.first[:isbn]).to eq(["9780062457714", "0062457713"])
      expect(books_data.books.first[:title]).to eq("The Lord of the Rings")
      expect(books_data.books.first[:publisher]).to eq(["testpublisher", "testpublisher2"])
    end
  end
end
