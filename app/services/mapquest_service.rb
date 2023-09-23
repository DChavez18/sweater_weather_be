class MapquestService
  def get_mapquest_data(location)
    api_key = Rails.application.credentials.dig(:MAPQUEST_API_KEY)
    get_url("/geocoding/v1/address?location=#{location}&key=#{api_key}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com/')
  end
end