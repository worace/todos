require 'test_helper'

class TaskTest < ActiveSupport::TestCase
 test "fills duedate with default if not provided" do
   Timecop.freeze do
     t = Task.create
     assert_equal 2.weeks.from_now, t.due_date
     assert_equal 1.day.from_now, Task.create(due_date: 1.day.from_now).due_date
   end
 end

 test "#complete?" do
   t = Task.create
   refute t.complete?
   t.complete!
   assert t.complete?
 end

 test "toggling" do
   t = Task.create
   refute t.complete?
   assert t.incomplete?
   t.toggle!
   assert t.complete?
   refute t.incomplete?
   t.toggle!
   refute t.complete?
   assert t.incomplete?
 end
end
