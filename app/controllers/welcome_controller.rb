class WelcomeController < ApplicationController
  def index
    json = GithubService.new
  end
end
