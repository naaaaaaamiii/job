class AttendeesController < ApplicationController
  def create
    @attendee = current_user.attendees.new(event_id: params[:event_id])
    @attendee.save
    redirect_to request.referer
  end
  
  def destroy
    @attendee = current_user.attendees.find_by(event_id: params[:event_id])
    @attendee.destroy
    redirect_to request.referer
  end
  
end
