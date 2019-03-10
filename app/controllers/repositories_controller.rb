class RepositoriesController < ApplicationController
  def index

    client = Octokit::Client.new
    if params[:query].present?
      @git_request ||= client.search_repositories(params[:query], page: params[:page], sort: "stars")
      @result = @git_request[:items].map do |item|
        {
         name: item[:full_name],
         description: item[:description],
         url: item[:html_url],
         stars_nbr: item[:stargazers_count],
         open_issues: item[:open_issues_count],
       }
      end
      results_count = @git_request[:total_count]
      remainder = results_count % 30
      @max_page_count = results_count.div 30
      @max_page_count += 1 if remainder > 0

    end
  end

end