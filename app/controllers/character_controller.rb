class CharactersController < ApplicationController 
  # before_action :correct_user,    only: [:move, :kill] 
  before_action :admin_user,      only: [:destroy] 
  

  def vote 
    @game = Game.find(1)
    @voter = Character.find(params[:id])
    @voted = Character.find(params[:victimid])

    if @voter.werewolf and @game.night
      @voted.were_vote += 1
      respond_with(@voter) do |format| 
        format.json {render :json => { :success => :true} }
      end

    elsif @voter.werewolf and !@game.night
      respond_with(@voter) do |format| 
        format.json {render :json => { :success => :false, :error => "You can only vote to kill at night!" } }
      end

    elsif !@voter.werewolf and !@game.night
      @voted.town_vote += 1
      respond_with(@voter) do |format| 
        format.json {render :json => { :success => :true} }
      end

    elsif !@voter.werewolf and @game.night
      respond_with(@voter) do |format| 
        format.json {render :json => { :success => :false, :error => "You can only vote during the day!" } }
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
