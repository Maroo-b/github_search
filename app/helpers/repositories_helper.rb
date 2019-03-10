module RepositoriesHelper

  def previous_link(query:, page:)
    if page.to_i == 1
      return content_tag(:li, link_to("Previous", "#", class: "page-link disabled"), class: "page-item disabled")
    end
    content_tag(:li, link_to("Previous", repositories_path(query: query, page: page.to_i - 1), class: "page-link"), class: "page_item")
  end

  def next_link(query:, page:, max_page:)
    if page.to_i == max_page
      return content_tag(:li, link_to("Next", "#", class: "page-link disabled"), class: "page-item disabled")
    end
    content_tag(:li, link_to("Next", repositories_path(query: query, page: page.to_i + 1), class: "page-link"), class: "page-item")
  end
end