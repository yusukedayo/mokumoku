# frozen_string_literal: true

class Events::AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
      event_attendance = current_user.attend(@event)
      unless event_attendance.id == nil
        (@event.attendees - [current_user] + [@event.user]).uniq.each do |user|
          NotificationFacade.attended_to_event(event_attendance, user)
        end
        redirect_back(fallback_location: root_path, success: '参加の申込をしました')
      else
        redirect_back(fallback_location: root_path, danger: "#{event_attendance.adjust_error_message}")
      end
  end

  def destroy
    @event = Event.find(params[:event_id])
    current_user.cancel_attend(@event)
    redirect_back(fallback_location: root_path, success: '申込をキャンセルしました')
  end
end
