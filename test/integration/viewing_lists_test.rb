class ViewingListsTest < ActionDispatch::IntegrationTest
  def test_it_creates_a_list
    visit root_path
    assert page.has_content?("Create list")
    click_link_or_button "Create list"
    fill_in "list_title", with: "My List"
    click_link_or_button "Create"
    assert_equal root_path, current_path
    assert_equal "My List", List.last.title
  end
end
