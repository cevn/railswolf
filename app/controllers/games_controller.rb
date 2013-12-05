class GamesController < ApplicationController
  before_action :admin_user,     only: [:create, :destroy] 

  def new 
    @game = Game.new
    @game.active = :true 
    @game.night = :true 
    @game.num_alive = Character.where(:dead => false).all.count

    @characters = Character.all 
    @characters = @characters.shuffle!

    @numWerewolves = @characters.count/4

    @game.num_were = @numWerewolves
    @game.num_town = @game.num_alive - @game.num_were

    (0..@numWerewolves).each do |i|
      @character = @characters[i]
      @character.werewolf = true
    end

    @game.save

    render 'manage' 
  end

  def show
    render 'create' 
  end 

  def update
    @characters = Character.where(:dead => false).all

    @game = Game.find(1) 
    if @game.active 
      @time = Time.now 
      @game.night = !@game.night

      if @time.hour % 2 == 0
        @charToKill = @characters.sort(:town_votes).first
      else # Used to be night
        @charToKill = @characters.sort(:were_votes).first
      end

      @charToKill.execute

      if @game.num_were == 0
        finish
        elsif @game.num_town == 0
          finish
        elsif @game.num_alive == 0
          finish
      end
    end
  end

  def finish
    @game = Game.find(1) 
    game.active = false
  end

  def destroy 
    @game = Game.find(1) 
    game.active = false
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
