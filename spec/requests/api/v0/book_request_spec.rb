require "rails_helper"

RSpec.describe "Book API" do
  describe "happy path" do
    it "returns book data and forecast for a city" do

      get "/api/v0/book-search?location=denver,co&quantity=5"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      book_data = JSON.parse(response.body, symbolize_names: true)

      puts book_data
      
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
      expect(book_data[:data][:attributes][:forecast]).to have_key(:high)
    end
  end
end