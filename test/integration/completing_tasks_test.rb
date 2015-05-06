require "test_helper"

class CompletingTasksTest < ActionDispatch::IntegrationTest
  def test_completes_task
    Capybara.current_driver = Capybara.javascript_driver
    l = List.create(title: "My List")
    t = l.tasks.create(description: "do a thing")
    visit list_path(l)
    click_link_or_button "Complete"
    assert_equal list_path(l), current_path
    assert t.reload.completed?
    Capybara.current_driver = Capybara.default_driver
  end
end

