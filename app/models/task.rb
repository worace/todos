class Task < ActiveRecord::Base
  belongs_to :list
  before_create :default_due_date

  def default_due_date
    self.due_date = 2.weeks.from_now unless self.due_date
  end

  def complete?
    status == "complete"
  end

  def incomplete?
    status == "incomplete"
  end

  def toggle!
    if incomplete?
      self.status = "complete"
    else
      self.status = "incomplete"
    end
    save
  end

  def complete!
    self.status = "complete"
    save
  end

  def as_json(options={})
    super(options).merge(due_date: due_date.strftime("%A, %b %d"))
  end
end
