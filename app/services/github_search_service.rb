class GithubSearchService
  PER_PAGE = 30
  SORT_FIELD = 'stars'.freeze

  attr_reader :query, :page

  def initialize(query:, page:)
    @query = query
    @page = page
  end

  def repositories_data
    search_repositories[:items].map do |item|
      {
        name: item[:full_name],
        description: item[:description],
        url: item[:html_url],
        stars_count: item[:stargazers_count],
        open_issues_count: item[:open_issues_count]
      }
    end
  end

  def page_count
    last_page_result = search_repositories[:total_count] % PER_PAGE
    nbr_pages = search_repositories[:total_count].div PER_PAGE
    return nbr_pages if last_page_result.zero?
    nbr_pages + 1
  end

  private

  def client
    @client ||= Octokit::Client.new
  end

  def search_repositories
    @search_repositories ||= client.search_repositories(
      query,
      page: page,
      sort: SORT_FIELD,
      per_page: PER_PAGE
    )
  end
end
