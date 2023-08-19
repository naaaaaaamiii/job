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
    @event = Event.find(params[:id])
    @event.creator = current_user
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render "edit"
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
    redirect_to events_path
  end
  
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
    @user = @event.creator
    @attendee = Attendee.find_by(user_id: current_user.id, event_id: @event.id)
  end
  
  
  private
  
  def event_params
    params.require(:event).permit(:event_image, :event_name, :event_introduction, :date, :url, :postal_code, :adress)
  end
  
end
