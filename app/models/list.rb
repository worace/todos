class List < ActiveRecord::Base

  def self.active
    where(archived: false)
  end

  def self.archived
    where(archived: true)
  end

  def archive!
    self.archived = true
    save
  end
end
