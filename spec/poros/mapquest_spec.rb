require "rails_helper"

RSpec.describe Mapquest do
  it "exists" do
    data = {
      :lat=>39.738453,
      :lng=>-104.984853
    }
    mapquest = Mapquest.new(data)

    expect(mapquest).to be_a(Mapquest)
    expect(mapquest.lat).to eq(39.738453)
    expect(mapquest.lon).to eq(-104.984853)
  end
end