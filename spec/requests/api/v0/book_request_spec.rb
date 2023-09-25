require "rails_helper"

RSpec.describe "Book API" do
  describe "happy path" do
    it "returns book data and forecast for a city" do

      get "/api/v0/book-search?location=denver,co&quantity=5"

      expect(response).to be_successful
      expect(response.status).to eq(200)

    end
  end
end