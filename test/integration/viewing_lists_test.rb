class ViewingListsTest < ActionDispatch::IntegrationTest
  def test_it_creates_a_list
    visit root_path
    assert page.has_content?("Create list")
    click_link_or_button "Create list"
    fill_in "list_title", with: "My List"
    click_link_or_button "Submit"
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

  def test_it_renames_a_list
    List.create(title: "My List")
    visit root_path
    click_link_or_button "My List"
    assert_equal list_path(List.first), current_path
    click_link_or_button "edit"
    fill_in "list_title", with: "new title"
    click_link_or_button "Submit"
    assert_equal list_path(List.first), current_path
    assert page.has_content?("new title")
  end

  def test_it_archives_a_list
    l = List.create(title: "My List")
    visit list_path(l)
    click_link_or_button "archive"
    assert_equal lists_path, current_path
    refute page.has_content?("My List")
    assert List.archived.first.archived?
  end

  def test_it_allows_viewing_archived_lists
    List.create(title: "My List", archived: true)
    visit root_path
    refute page.has_content?("My List")
    click_link_or_button "archived"
    assert page.has_content?("My List")
    assert page.has_link?("active")
    refute page.has_link?("archived")
  end

  def test_allows_deleting_archived_list
    List.create(title: "My List", archived: true)
    visit root_path
    click_link_or_button "archived"
    assert page.has_content?("My List")
    click_link_or_button("delete list")
    assert_equal root_path, current_path
    assert_equal 0, List.count
  end
end
