# frozen_string_literal: true

class EventAttendance < ApplicationRecord
  include Notifiable
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id }
  validate :check_set_gender
  validate :check_set_woman
  validate :check_set_man

  def check_set_gender
    if  Event.find(event_id).gender_ratio != 'not_set' && User.find(user_id).gender == 'not_set'
      errors.add(:user_id, '性別を設定してから申し込んでください')
    end
  end

  def check_set_woman
    if  Event.find(event_id).gender_ratio == 'only_woman' && User.find(user_id).gender == 'man'
      errors.add(:user_id, '女性限定です')
    end
  end

  def check_set_man
    if  Event.find(event_id).gender_ratio  == 'only_man' && User.find(user_id).gender == 'woman'
      errors.add(:user_id, '男性限定です')
    end
  end
end
