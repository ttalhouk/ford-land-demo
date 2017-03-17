class Service < ApplicationRecord
  belongs_to :user

  def self.delete_old_records
    where(['updated_at < ? AND open = ?', 10.days.ago, false]).destroy_all
  end
end
