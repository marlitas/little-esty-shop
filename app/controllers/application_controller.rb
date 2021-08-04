class ApplicationController < ActionController::Base
  before_action :repo_fetch
  def repo_fetch
    json = GithubService.new.repo_name
    @repo = Repo.new(json)
  end

end
