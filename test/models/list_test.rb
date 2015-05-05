require 'test_helper'

class ListTest < ActiveSupport::TestCase
   test "it starts as not archived" do
     refute List.create(title: "pizza").archived?
   end
end
