# frozen_string_literal: true

class Events::AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    if @event.check(current_user)
      redirect_back(fallback_location: root_path, success: '参加に失敗しました 性別欄を確認してください')
    else
      event_attendance = current_user.attend(@event)
      (@event.attendees - [current_user] + [@event.user]).uniq.each do |user|
        NotificationFacade.attended_to_event(event_attendance, user)
      end
      redirect_back(fallback_location: root_path, success: '参加の申込をしました')
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    current_user.cancel_attend(@event)
    redirect_back(fallback_location: root_path, success: '申込をキャンセルしました')
  end
end
