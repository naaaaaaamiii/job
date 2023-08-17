class EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.save!
  end
  
  def index
  end
  
  def show
  end
  
  
  private
  
  def event_params
    params.require(:event).permit(:event_title, :introduction, :event_image)
  end
  
end
