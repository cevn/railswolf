class GameController < ApplicationController
  before_action :admin_user,     only: [:create, :destroy] 
  respond_to :json, :html

  def create
    render :create
  end

  def show
  end 

  def update
    render :edit
  end

  def destroy 
    render :end
  end 

  def index
    @kills = Kill.paginate(page: params[:page])
    respond_with @kills
  end

  private
    def admin_user
      if !current_user.admin? 
        redirect_to(root_url) 
      end
    end
end
