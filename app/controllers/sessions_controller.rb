class SessionsController < Devise::SessionsController
  respond_to :json, :html

  def new
    super
  end

  def create
    super
  end
    
  def destroy
    super
  end
end
