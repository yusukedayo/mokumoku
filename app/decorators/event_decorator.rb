# frozen_string_literal: true

class EventDecorator < Draper::Decorator
  delegate_all

  def thumbnail
    object.thumbnail.presence || 'event-default-image.png'
  end

  def show_reason_cannot_attend
    if object.confirm_attendance_limit
      "満員です"
    elsif object.confirm_man_attendance_limit
      "このイベントの男性枠は満員です"
    else object.confirm_woman_attendance_limit
      "このイベントの女性枠は満員です"
    end
  end
end
