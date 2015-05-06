class Task < ActiveRecord::Base
  belongs_to :list
  before_create :default_due_date
  after_create :email_notifs

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

  def cc_regex
    /\/cc (.+)(\s|$)/
  end

  def email_notifs
    if match = description.match(cc_regex)
      email = match[1]
      Rails.logger.info("Got a match, sneding an email to #{email}")
      TaskNotificationMailer.cc_email(email, self).deliver
    end
  end

  def as_json(options={})
    super(options).merge(due_date: due_date.strftime("%A, %b %d"))
  end
end
