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
    return unless Event.find(event_id).gender_ratio != 'not_set' && User.find(user_id).gender == 'not_set'

    errors.add(:user_id, 'このもくもく会には性別を設定してから申し込んでください')
  end

  def check_set_woman
    return unless Event.find(event_id).gender_ratio == 'only_woman' && User.find(user_id).gender == 'man'

    errors.add(:user_id, 'このもくもく会は女性限定です')
  end

  def check_set_man
    return unless Event.find(event_id).gender_ratio == 'only_man' && User.find(user_id).gender == 'woman'

    errors.add(:user_id, 'このもくもく会は男性限定です')
  end

  def adjust_error_message
    errors.full_messages.join.delete('User')
  end
end
