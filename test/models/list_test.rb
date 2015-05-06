require 'test_helper'

class ListTest < ActiveSupport::TestCase
   test "it starts as not archived" do
     refute List.create(title: "pizza").archived?
   end

   test "it archives" do
     l = List.create
     refute l.archived?
     l.archive!
     assert l.archived?
   end

   test "active scope gets unarchived ones" do
     l = List.create
     assert_equal [l], List.active
     l.archive!
     assert_equal [], List.active
     assert_equal [l], List.archived
   end

   test "has tasks" do
     l = List.create
     l.tasks.create(description: "do laundry")
     assert_equal 1, l.tasks.count
   end
end
