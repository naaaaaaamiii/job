class EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.save!
    redirect_to request.referer
  end
  
  def index
  end
  
  def show
  end
  
  
  private
  
  def event_params
    params.require(:event).permit(:event_image, :event_name, :event_introduction, :date, :url, :postal_code, :adress)
  end
  
end
