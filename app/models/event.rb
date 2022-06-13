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

  enum gender_ratio: { not_set: 0, only_woman: 1, only_man: 2, half: 3}

  with_options presence: true do
    validates :title
    validates :content
    validates :held_at
  end

  def past?
    held_at < Time.current
  end

  def future?
    !past?
  end

  def check(user)
    check_set_gender(user) || check_gender_man(user) || check_gender_woman(user)
  end

  def check_set_gender(user)
    self.gender_ratio != "not_set" && user.gender == "not_set"
  end

  def check_gender_man(user)
    self.gender_ratio == "only_woman" && user.gender == "man"
  end

  def check_gender_woman(user)
    self.gender_ratio == "only_man" && user.gender == "woman"
  end

  def check_participants?
    if number_of_participants <= attendees.size
      false
    elsif gender_ratio == "half" && number_of_participants / 2 <= attendees.where(gender: "man").size
      false
    elsif gender_ratio == "half" && number_of_participants / 2 <= attendees.where(gender: "woman").size
      false
    else
      true
    end
  end
end
