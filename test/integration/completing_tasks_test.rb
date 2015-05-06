require "test_helper"
Capybara.default_wait_time = 3

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection ||= ConnectionPool::Wrapper.new(size: 1) { retrieve_connection }
  end
end
ActiveRecord::Base.connection

class CompletingTasksTest < ActionDispatch::IntegrationTest

  def test_completes_task
    Capybara.current_driver = Capybara.javascript_driver
    l = List.create(title: "My List")
    t = l.tasks.create(description: "do a thing")
    visit list_path(l)
    click_link_or_button "update"
    assert_equal list_path(l), current_path
    assert t.reload.complete?
    Capybara.current_driver = Capybara.default_driver
  end

  def test_viewing_completed_tasks
    Capybara.current_driver = Capybara.javascript_driver

    l = List.create(title: "My List")
    l.tasks.create(description: "do a thing")
    visit list_path(l)
    assert page.has_selector?("li.hidden", count: 0)
    click_link_or_button "update"
    assert Task.first.reload.complete?
    assert_equal list_path(l), current_path
    refute page.has_content?("do a thing")
    click_link_or_button "show completed tasks"
    assert page.has_content?("do a thing")

    Capybara.current_driver = Capybara.default_driver
  end
end

