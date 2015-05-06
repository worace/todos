require "csv"
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

  def to_csv
    CSV.generate do |csv|
      csv << Task.column_names
      tasks.each do |t|
        csv << t.attributes.values
      end
    end
  end
end
