class RepositoriesController < ApplicationController
  def index

    if params[:query].present?
      search_data ||= GithubSearchService.new(query: params[:query], page: params[:page])

      @repositories = search_data.repositories_data
      @page_count = search_data.page_count
    end
  end

end