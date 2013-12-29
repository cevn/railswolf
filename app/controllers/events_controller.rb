class EventsController < ApplicationController

  def index 
    events = Event.load
    respond_with events 
  end
end
