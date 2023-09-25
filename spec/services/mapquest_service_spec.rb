require "rails_helper"

RSpec.describe "Mapquest Service" do
  describe "instance methods" do
    it "returns lat and lon for a city" do
      mapquest = MapquestService.new
      mapquest_data = mapquest.get_mapquest_data("denver,co")

      expect(mapquest_data).to be_a(Hash)
      expect(mapquest_data).to have_key(:results)
      expect(mapquest_data[:results]).to be_an(Array)
      expect(mapquest_data[:results][0]).to have_key(:locations)
      expect(mapquest_data[:results][0][:locations]).to be_an(Array)
      expect(mapquest_data[:results][0][:locations][0]).to have_key(:latLng)
      expect(mapquest_data[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(mapquest_data[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(mapquest_data[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(mapquest_data[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(mapquest_data[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end
  end
end