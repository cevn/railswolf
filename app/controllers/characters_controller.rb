class CharactersController < ApplicationController

  def dead?
    @character = Character.find(params[:user_id])
    return @character.dead
  end

end
