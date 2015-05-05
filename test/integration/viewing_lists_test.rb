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

  def test_it_renders_a_list
    List.create(title: "My List")
    visit root_path
    assert page.has_content?("My List")
  end

  def test_it_doesnt_show_archived_lists
    List.create(title: "My List")
    List.create(title: "Archived", archived: true)
    visit root_path
    assert page.has_content?("My List")
    refute page.has_content?("Archived")
  end
end
