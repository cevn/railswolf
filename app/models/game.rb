class Game < ActiveRecord::Base

  def self.update_game
    puts "Starting game update..." 
    puts "Finding characters" 
    @characters = Character.where(:dead => false).load

    puts "Finding game" 
    @game = Game.find_by_id(1) 

    puts "Checking game activity"
    if @game and @game.active 
      @charactervotes = Character.where(:dead => false).load
      @charactervotes.each do |char| 
        char.voted = false
      end

      puts "Game is active. Updating.." 
      @time = Time.now 
      @game.night = !@game.night

      if !@game.night
        @charToKill = @characters.order(:votes).last
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

  def self.finish
    @game = Game.find(1) 
    puts "Game is over!" 
    if @game.num_were == 0
      puts "Townspeople won!"
    elsif @game.num_town == 0
      puts "Werewolves won!" 
    end
    @game.active = false 
    @game.save 
  end
end
