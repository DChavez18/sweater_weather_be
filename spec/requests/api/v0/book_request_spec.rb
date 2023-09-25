require "rails_helper"

RSpec.describe "Book API" do
  describe "happy path" do
    it "returns book data and forecast for a city" do

      get "/api/v0/book-search?location=denver,co&quantity=5"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      book_data = JSON.parse(response.body, symbolize_names: true)

      expect(book_data).to be_a(Hash)
      expect(book_data).to have_key(:data)
      expect(book_data[:data]).to be_a(Hash)
      expect(book_data[:data]).to have_key(:id)
      expect(book_data[:data][:id]).to eq("null")
      expect(book_data[:data]).to have_key(:type)
      expect(book_data[:data][:type]).to eq("books")
      expect(book_data[:data]).to have_key(:attributes)
      expect(book_data[:data][:attributes]).to be_a(Hash)
      expect(book_data[:data][:attributes]).to have_key(:destination)
      expect(book_data[:data][:attributes][:destination]).to be_a(String)
      expect(book_data[:data][:attributes]).to have_key(:forecast)
      expect(book_data[:data][:attributes][:forecast]).to be_a(Hash)
      expect(book_data[:data][:attributes][:forecast]).to have_key(:summary)
      expect(book_data[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(book_data[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(book_data[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(book_data[:data][:attributes][:forecast]).to_not have_key(:high)
      expect(book_data[:data][:attributes][:forecast]).to_not have_key(:low)
      expect(book_data[:data][:attributes]).to have_key(:books)
      expect(book_data[:data][:attributes][:books]).to be_an(Array)
      expect(book_data[:data][:attributes][:books].count).to eq(5)
      expect(book_data[:data][:attributes][:books][0]).to have_key(:isbn)
      expect(book_data[:data][:attributes][:books][0][:isbn]).to be_an(Array)
      expect(book_data[:data][:attributes][:books][0][:isbn].count).to eq(2)
      expect(book_data[:data][:attributes][:books][0]).to have_key(:title)
      expect(book_data[:data][:attributes][:books][0][:title]).to be_a(String)
      expect(book_data[:data][:attributes][:books][0]).to have_key(:publisher)
      expect(book_data[:data][:attributes][:books][0][:publisher]).to be_an(Array)
      expect(book_data[:data][:attributes][:books][0][:publisher].count).to eq(1)

      book_data[:data][:attributes][:books].each do |book|
        expect(book).to be_a(Hash)
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an(Array)
        expect(book[:isbn].count).to eq(2)
        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)
        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an(Array)
        expect(book[:publisher].count).to eq(1)
      end
    end
  end
end