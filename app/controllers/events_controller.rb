class EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    if @event.save
       flash[:notice] = "Success🎉"
       redirect_to event_path(@event)
    else
      flash.now[:alert] = "Error🫠"
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
      flash[:notice] = "Success🎉"
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Error🫠"
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
  
  def myevent
    @events = Event.all
    
    if params[:event_type] == "created_events"
      @myevents = @events.where(creator_id: current_user.id)
    elsif params[:event_type] == "attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where.not(creator_id: current_user.id).page(params[:page]).per(8)
    elsif params[:event_type] == "past_attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date < ?", Time.now).where.not(creator_id: current_user.id).page(params[:page]).per(8)
    else
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).page(params[:page]).per(8)
    end
  end
  
  
  private
  
  def event_params
    params.require(:event).permit(:event_image, :event_name, :event_introduction, :date, :url, :postal_code, :adress)
  end
  
end
