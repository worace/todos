class List < ActiveRecord::Base
  has_many :tasks

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
