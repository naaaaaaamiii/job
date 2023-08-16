class EventsController < ApplicationController
  
  def new
    @event = Event.new
    @post_tags = @post.post_tags.pluck(:name).join(',')
  end
  
  def index
  end
  
  def show
  end
end
