require "test_helper"

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection ||= ConnectionPool::Wrapper.new(size: 1) { retrieve_connection }
  end
end
ActiveRecord::Base.connection

class AddingTasksToListTest < ActionDispatch::IntegrationTest
  def test_adding_task
    Capybara.current_driver = Capybara.javascript_driver
    l = List.create(title: "My List", archived: true)
    visit list_path(l)
    assert page.has_selector?("li.task", count: 0)
    fill_in "task_description", with: "order pizza"
    click_link_or_button "Submit"
    assert page.has_selector?("li.task", count: 1)
    Capybara.current_driver = Capybara.default_driver
  end

  def test_editing_task
    Capybara.current_driver = Capybara.javascript_driver
    l = List.create(title: "My List", archived: true)
    t = l.tasks.create(description: "do a thing")
    visit list_path(l)
    within "li.task" do
      click_link_or_button "edit"
    end
    fill_in "task_description", with: "order pizza"
    click_link_or_button "Submit"
    assert_equal list_path(l), current_path
    assert_equal "order pizza", t.reload.description
    Capybara.current_driver = Capybara.default_driver
  end
end
