class Game < ActiveRecord::Base

  def self.update_game
    puts "Starting game update..." 
    puts "Finding characters" 
    @characters = Character.where(:dead => false).load

    puts "Finding game" 
    @game = Game.find(1) 

    puts "Checking game activity"
    if @game.active 
      puts "Game is active. Updating.." 
      @time = Time.now 
      @game.night = !@game.night

      if @time.hour % 2 == 0
        @charToKill = @characters.order(:town_votes).first
      else # Used to be night
        @charToKill = @characters.order(:were_votes).first
      end

      puts "Character to kill: " + @charToKill.user.name
      @charToKill.dead = true
      @charToKill.save
      @game.num_alive-=1

      if char.werewolf
        @game.num_were-=1
      else
        @game.num_town-=1
      end

      if @game.num_were == 0
        finish
        elsif @game.num_town == 0
          finish
        elsif @game.num_alive == 0
          finish
      end
    end

    @game.save
  end
end
