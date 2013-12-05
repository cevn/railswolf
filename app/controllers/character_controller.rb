class CharactersController < ApplicationController 
  before_action :correct_char,    only: [:move, :kill] 
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


  # Method is called every hour, when votes are tallied
  def execute(char) 
    @game = Game.find(1) 
    @game.num_alive -= 1

    if char.werewolf
      @game.num_were -= 1
    else
      @game.num_town -= 1
    end
      
  end

  private 
    def move_params
      params.require(:character).permit(:lat, :long)
    end

    def correct_char
      @char = Character.find(params[:id])
      redirect_to root_url unless current_char?(@char)
    end

    def werewolf_char
      flash[:error] = "You must be a werewolf to view that page!" 
      redirect_to(root_url) unless current_char.werewolf?
    end
end
