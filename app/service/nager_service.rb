class NagerService
  def get_holiday
    year = Time.now.strftime('%Y')
    endpoint = "https://date.nager.at/api/v1/Get/us/#{year}"
    get_data(endpoint)
  end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end
end
