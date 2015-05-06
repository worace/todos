require "test_helper"

class CompletingTasksTest < ActionDispatch::IntegrationTest
  def test_completes_task
    l = List.create(title: "My List")
    t = List.tasks.create(description: "do a thing")
    visit list_path(l)
    click_link_or_button "#complete-task-#{t.id}"
  end
end

