require 'rails_helper'

describe GithubSearchService do
  let(:stubbed_search) do
    {
      total_count: 70,
      incomplete_results: false,
      items:       [
        {
          id: 8514,
          node_id: 'MDEwOlJlcG9zaXRvcnk4NTE0',
          name: 'rails',
          full_name: 'rails/rails',
          private: false,
          html_url: 'https://github.com/rails/rails',
          description: 'Ruby on Rails',
          fork: false,
          stargazers_count: 42_435,
          watchers_count: 42_435,
          language: 'Ruby',
          open_issues_count: 1139
        },

        {
          id: 10_496_245,
          node_id: 'MDEwOlJlcG9zaXRvcnkxMDQ5NjI0NQ==',
          name: 'rails',
          full_name: 'capistrano/rails',
          private: false,
          html_url: 'https://github.com/capistrano/rails',
          description: 'Official Ruby on Rails specific tasks for Capistrano',
          fork: false,
          stargazers_count: 682,
          watchers_count: 682,
          language: 'Ruby',
          open_issues_count: 11
        },

        {
          id: 810_796,
          node_id: 'MDEwOlJlcG9zaXRvcnk4MTA3OTY=',
          name: 'rails_admin',
          full_name: 'sferik/rails_admin',
          private: false,
          html_url: 'https://github.com/sferik/rails_admin',
          description:           'RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data',
          fork: false,
          stargazers_count: 7025,
          watchers_count: 7025,
          language: 'Ruby',
          open_issues_count: 424
        }
      ]
    }
  end

  let(:fake_client) { double(search_repositories: stubbed_search) }

  before do
    allow(Octokit::Client).to receive(:new).and_return(fake_client)
  end

  subject do
    described_class.new(query: 'rails', page: 1)
  end

  describe '#repositories_data' do
    it 'returns an array containing the following details' do
      expect(subject.repositories_data).to eq(
        [
          {
            name: 'rails/rails',
            description: 'Ruby on Rails',
            url: 'https://github.com/rails/rails',
            stars_count: 42_435,
            open_issues_count: 1139
          },
          {
            name: 'capistrano/rails',
            description: 'Official Ruby on Rails specific tasks for Capistrano',
            url: 'https://github.com/capistrano/rails',
            stars_count: 682,
            open_issues_count: 11
          },
          {
            name: 'sferik/rails_admin',
            description: 'RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data',
            url: 'https://github.com/sferik/rails_admin',
            stars_count: 7025,
            open_issues_count: 424
          }
        ]
      )
    end
  end

  describe '#page_count' do
    it 'returns the number of pages required to display search result' do
      expect(subject.page_count).to eq(3)
    end
  end
end
