class CharactersController < ApplicationController 
  before_action :correct_char,    only: [:move, :kill] 
  before_action :admin_user,      only: [:destroy] 

  respond_to :json, :html
  

  def kill
    @killer = Character.find(params[:killerid])
    @victim = Character.find(params[:victimid])

    if @killer.werewolf and night? getTime
      @victim.isDead = true
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

    def correct_char
      @char = Character.find(params[:id])
      redirect_to root_url unless current_char?(@char)
    end

    def werewolf_char
      flash[:error] = "You must be a werewolf to view that page!" 
      redirect_to(root_url) unless current_char.werewolf?
    end
end
