class MapquestService
  def get_directions_data(origin, destination)
    get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
  end

  def get_mapquest_data(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com/') do |faraday|
      faraday.params["key"] = Rails.application.credentials.dig(:MAPQUEST_API_KEY)
    end
  end
end