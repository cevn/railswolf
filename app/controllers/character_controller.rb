class CharactersController < ApplicationController 
  # before_action :correct_user,    only: [:move, :kill] 
  before_action :admin_user,      only: [:destroy] 
  

  def kill 
    @game = Game.find_by_id(1)
    @killer = Character.find(params[:id]) 
    @victim = Character.find(params[:victimid]) 

    if @game and @game.night
      if @killer.werewolf 
        @victim.dead = true
        respond_with @victim do |format| 
          format.json {render :json => { :success => true } }
        end
      end
    end
  end 

  def show_alive 
    @living_chars = Character.where(:dead => :false).all
    respond_with(@living_chars)
  end

  def vote 
    @game = Game.find_by_id(1)
    @voted = Character.find(params[:victimid])
    @char = Character.find(params[:user_id]) 


    if @game and @game.night
      respond_with(@voted) do |format| 
        format.json {render :json => { :success => :false, :error => "You can only vote during the day!" } }
      end
    else 
      if !@char.voted
        @voted.votes += 1
        @voted.save
        @char.voted = true 
        @char.save
        respond_with(@voted) do |format| 
          format.json {render :json => { :success => true } } 
      end
      else 
        respond_with(@voted) do |format| 
          format.json {render :json => { :success => :false, :error => "You can only vote once per day." } }
        end
      end
    end
  end

  def move
    @char = Character.find(params[:id]) 

    if @char.update_attributes(move_params)
      respond_with(@char) do |format| 
        format.json {render :json => { :success => true }} 
      end
    else 
      respond_with(@char) do |format| 
        format.json {render :json => { :success => false }}
      end
    end
  end

  private 
    def move_params
      params.require(:character).permit(:lat, :long)
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def werewolf_char
      @user = User.find(params[:id]) 
      flash[:error] = "You must be a werewolf to view that page!" 
      redirect_to(root_url) unless user.character.werewolf?
    end
end
