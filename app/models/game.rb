class Game < ActiveRecord::Base

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
end
