class EventsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
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
    @event.creator = ensure_correct_user
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
    @events = Event.latest
  end
  
  def show
    @event = Event.find(params[:id])
    @user = @event.creator
    if user_signed_in?
      @attendee = Attendee.find_by(user_id: current_user.id, event_id: @event.id)
    end
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
  
   def ensure_correct_user
    @event = Event.find(params[:id])
    unless @event.creator == current_user
      redirect_to root_path
    end
   end
  
end
