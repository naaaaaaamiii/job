class AttendeesController < ApplicationController
  def create
    @attendee = current_user.attendees.new(attendee_id: params[:attendee_id])
    attendee.save
    redirect_to request.referer
  end
  
  def destroy
    @attendee = current_user.attendees.find_by(attendee_id: params[:attendee_id])
    attendee.destroy
    redirect_to request.referer
  end
  
end
