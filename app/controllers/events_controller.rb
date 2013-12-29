class EventsController < ApplicationController

  def index 
    events = Event.all
    respond_with(events)
  end
end
