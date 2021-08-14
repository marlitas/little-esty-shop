class GithubService
  def repo_name
    endpoint = "https://api.github.com/repos/marlitas/little-esty-shop"
    get_data(endpoint)
  end

  def contributor
    endpoint = "https://api.github.com/repos/marlitas/little-esty-shop/contributors"
    get_data(endpoint)
  end

  def pull_count
    endpoint = "https://api.github.com/repos/marlitas/little-esty-shop/pulls?state=all"
    get_data(endpoint)
  end

  def get_data(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end
end
