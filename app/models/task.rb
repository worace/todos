class Task < ActiveRecord::Base
  belongs_to :list
  before_create :default_due_date

  def default_due_date
    self.due_date = 2.weeks.from_now unless self.due_date
  end
end
