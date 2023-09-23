class WeatherService
  def get_weather_data(lat, lon)
    api_key = Rails.application.credentials.dig(:WEATHER_API_KEY)
    get_url("/v1/forecast.json?key=#{api_key}&q=#{lat},#{lon}&aqi=no")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com")
  end
end