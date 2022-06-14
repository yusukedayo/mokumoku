# frozen_string_literal: true

class EventAttendance < ApplicationRecord
  include Notifiable
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id }
  validate :check_gender_man

  def check_gender_man
    event = Event.find(event_id)
    user = User.find(user_id)
    errors.add(:event_id, '男性の方は女性限定イベントに参加できません') if event.gender_ratio == 'only_woman' && user.gender == 'man'
  end
end
