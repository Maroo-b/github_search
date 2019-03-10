class RepositoriesController < ApplicationController
  def index

    client = Octokit::Client.new
    if params[:query].present?
      @result = client.search_repositories(params[:query])[:items].map do |item|
        {
         name: item[:full_name],
         description: item[:description],
         url: item[:html_url],
         stars_nbr: item[:stargazers_count],
         open_issues: item[:open_issues_count],
       }
      end
    end
  end
end