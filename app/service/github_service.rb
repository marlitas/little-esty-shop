class GithubService
  def repo_name
    endpoint = "https://api.github.com/repos/marlitas/little-esty-shop"
    get_data(endpoint)
  end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end
end
