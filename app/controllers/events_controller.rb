class EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    if @event.save!
     redirect_to event_path(@event)
    else
      render "new"
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
  end
  
  def destroy
  end
  
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
    @user = @event.creator
  end
  
  
  private
  
  def event_params
    params.require(:event).permit(:event_image, :event_name, :event_introduction, :date, :url, :postal_code, :adress)
  end
  
end
