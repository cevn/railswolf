class Game < ActiveRecord::Base

  def self.update_game
    puts "Starting game update..." 
    puts "Finding characters" 
    characters = Character.where(:dead => false).load

    puts "Finding game" 
    game = Game.find_by_id(1) 

    puts "Checking game activity"
    if game and game.active 
      charactervotes = Character.where(:dead => false).load
      charactervotes.each do |char| 
        char.voted = false
        char.save
      end

      puts "Game is active. Updating.." 

      time = Time.now 

      if time.hour%2 == 0 
        game.night = true ## Used to be day, now it's night. 
        charToKill = characters.order(:votes).last
        puts "Character to kill: " + charToKill.user.name


        ## Add event to record 
        event = Event.new 
        event.victim = charToKill.user.name
        event.killer = "Townspeople" 
        event.latitude = charToKill.latitude 
        event.longitude= charToKill.longitude
        event.event_type = "execute" 
        event.save 

        charToKill.dead = true
        charToKill.save

        if !charToKill.user.registration_id.nil? and !charToKill.user.registration_id.empty?
          n = Rapns::Gcm::Notification.new 
          n.app = Rapns::Gcm::App.find_by_name("droidwolf") 
          n.data = {:message => "You have been executed by popular vote! Better luck next time."} 
          n.registration_ids = charToKill.user.registration_id
          n.save! 
          Rapns.push
        end

        ## Reset all votes and assign points
        ## Reload characters because one died 

        characters = Character.where(:dead => false).load 
        characters.each do |char|
          puts "Resetting votes for " + char.user.name
          char.votes = 0
          char.score += 100
          char.save 
        end

        game.num_alive = game.num_alive-1

        if charToKill.werewolf
          game.num_were = game.num_were-1
        else
          game.num_town = game.num_town-1
        end

        if game.num_were == 0
          finish
        elsif game.num_town == 0
          finish
        elsif game.num_alive == 0
          finish
        end
      else 
        characters = Character.where(:dead => false).load
        characters.each do |char| 
          puts "Adding score to " + char.user.name
          char.score += 100 
          char.save 
        end
        game.night = false
      end

    puts "Saving game..." 
    game.save
    end
  end

  def self.finish
    game = Game.find(1) 
    characters = Character.where(:dead => false).load 

    ## Add points for being alive at the end of the game
    characters.each do |char| 
      char.score += 1000
      char.save
    end

    ## Load all characters regardless of whether or not they're dead and reset
    #highscore and stuff. 
    characters = Character.load
    characters.each do |char| 
      if char.max_score < char.score 
        char.max_score = char.score
        char.save
      end
    end

    puts "Game is over!" 
    if game.num_were == 0
      puts "Townspeople won!"
    elsif game.num_town == 0
      puts "Werewolves won!" 
    end
    game.active = false 
    game.save 
  end
end
