class CharactersController < ApplicationController 
  # before_action :correct_user,    only: [:move, :kill] 
  before_action :admin_user,      only: [:destroy] 
  

  def kill 
    @game = Game.find(1)
    @killer = Character.find(params[:id]) 
    @victim = Character.find(params[:victimid]) 

    if @game.night
      if @killer.werewolf 
        @victim.dead = true
        respond_with @victim do |format| 
          format.json {render :json => { :success => true } }
        end
      end
    end

  end 

  def vote 
    @game = Game.find(1)
    @voted = Character.find(params[:victimid])

    if @game.night
      respond_with(@voted) do |format| 
        format.json {render :json => { :success => :false, :error => "You can only vote during the day!" } }
      end
    else 
      @voted.votes += 1
      respond_with(@voted) do |format| 
        format.json {render :json => { :success => true } } 
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
