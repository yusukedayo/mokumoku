class Tag < ApplicationRecord
  has_many :event_tags
  has_many :events, through: :event_tags
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
