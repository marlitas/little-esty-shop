class ApplicationController < ActionController::Base
  before_action :repo_fetch
  before_action :pull_count
  before_action :contributor_fetch

  def repo_fetch
    json = GithubService.new.repo_name
    @repo = Repo.new(json)
  end

  def pull_count
    @pull_count = GithubService.new.pull_count.count
  end

  def contributor_fetch
    json = GithubService.new.contributor
    @contributors = json.map do |contributor|
      Contributor.new(contributor)
    end
  end
end
