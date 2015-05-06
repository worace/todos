require "test_helper"

class AddingTasksToListTest < ActionDispatch::IntegrationTest
  def test_allows_deleting_archived_list
    l = List.create(title: "My List", archived: true)
    visit list_path(l)
    assert page.has_selector?("li.task", count: 0)
    fill_in "task_description", with: "order pizza"
    click_link_or_button "Submit"
    assert page.has_selector?("li.task", count: 1)
  end
end
