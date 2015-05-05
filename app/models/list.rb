class List < ActiveRecord::Base
  default_scope { where(archived: false) }
end
