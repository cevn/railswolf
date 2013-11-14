class GameController < ApplicationController
  before_action :admin_user,     only: [:create, :destroy] 
  respond_to :json, :html

  def create
    @game = Game.new
    @users = User.all
    @users.each do |user|
      @character = Character.new(user.id)
    end

    @characters = Character.all 
    @characters = @characters.shuffle!

    @numWerewolves = @characters.count/4

    0..@numWerewolves.each do |i|
      @character = @characters[i]
      @character.werewolf = true
    end
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

  def night?  
    @time = Time.now
    !((6...21).include? @time.hour)
  end

  private
    def admin_user
      if !current_user.admin? 
        redirect_to(root_url) 
      end
    end
end
