require "rails_helper"

RSpec.describe Books do
  describe "instance methods" do
    it "exists" do
      books_data = Books.new("denver,co", {:summary=>"Sunny", :temperature=>80}, 80, [{:isbn=>["9780062457714", "0062457713"], :title=>"The Subtle Art of Not Giving a F*ck: A Counterintuitive Approach to Living a Good Life", :publisher=>["HarperOne", "HarperOne"]}])

      expect(books_data).to be_a(Books)
      expect(books_data.destination).to eq("denver,co")
      expect(books_data.forecast).to be_a(Hash)
      expect(books_data.forecast[:summary]).to eq("Sunny")
      expect(books_data.forecast[:temperature]).to eq(80)
    end
  end
end
