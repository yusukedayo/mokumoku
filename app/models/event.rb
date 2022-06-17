# frozen_string_literal: true

class Event < ApplicationRecord
  include Notifiable
  belongs_to :prefecture
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, class_name: 'User', source: :user
  has_many :attendances, dependent: :destroy, class_name: 'EventAttendance'
  has_many :attendees, through: :attendances, class_name: 'User', source: :user
  has_many :bookmarks, dependent: :destroy
  has_one_attached :thumbnail

  scope :future, -> { where('held_at > ?', Time.current) }
  scope :past, -> { where('held_at <= ?', Time.current) }

  enum gender_ratio: { not_set: 0, only_woman: 1, only_man: 2, half: 3 }

  with_options presence: true do
    validates :title
    validates :content
    validates :held_at
    validates :gender_ratio
  end
  validate :check_with_half_and_participants
  validate :participant_number

  def participant_number
    return unless !number_of_participants.nil? && number_of_participants < 1

    errors.add(:number_of_participants, '参加人数は1人以上に設定してください')
  end

  def check_with_half_and_participants
    return unless gender_ratio == 'half' && number_of_participants.nil?

    errors.add(:number_of_participants, '男女半々を選択した場合は参加人数を入力してください')
  end

  def past?
    held_at < Time.current
  end

  def future?
    !past?
  end

  def check_participants?
    if number_of_participants
      if check_all_number || check_man_number || check_woman_number
        false
      else
        true
      end
    else
      true
    end
  end

  def check_all_number
    number_of_participants <= attendees.size
  end

  def check_man_number
    gender_ratio == 'half' && number_of_participants / 2 <= attendees.where(gender: 'man').size
  end

  def check_woman_number
    gender_ratio == 'half' && number_of_participants / 2 <= attendees.where(gender: 'woman').size
  end
end
