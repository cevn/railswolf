class Game < ActiveRecord::Base

  def self.update_game
    puts "Starting game update..." 
    puts "Finding characters" 
    @characters = Character.where(:dead => false).load

    puts "Finding game" 
    @game = Game.find_by_id(1) 

    puts "Checking game activity"
    if @game and @game.active 
      puts "Game is active. Updating.." 
      @time = Time.now 
      @game.night = !@game.night

      if @time.hour % 2 == 0
        @charToKill = @characters.order(:votes).first
        puts "Character to kill: " + @charToKill.user.name
        @charToKill.dead = true
        @charToKill.save
        @game.num_alive = @game.num_alive-1

        if @charToKill.werewolf
          @game.num_were = @game.num_were-1
        else
          @game.num_town = @game.num_town-1
        end

        if @game.num_were == 0
          finish
        elsif @game.num_town == 0
          finish
        elsif @game.num_alive == 0
          finish
        end
      end
    puts "Saving game..." 
    @game.save
    end
  end
end
