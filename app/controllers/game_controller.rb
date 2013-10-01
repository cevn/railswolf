class GameController < ApplicationController
  before_action :admin_user,     only: [:create, :destroy, :index] 

  respond_to :json, :html
  def create
    render :create
  end

  def show
    @kills = Kill.paginate(page: params[:page])
    respond_with @kills
  end 

  def update
    render :edit
  end

  def destroy 
    render :end
  end 

  private
    def admin_user
      if !current_user.admin? 
        flash[:error] = "You need to be an admin to view that page." 
        redirect_to(root_url) 
      end
    end
end
