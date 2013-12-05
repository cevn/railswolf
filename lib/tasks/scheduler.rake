desc "This task is called by the Heroku scheduler add-on"
task :update_game => :environment do
  puts "Updating game..."
  @game = Game.find(1)
  @game.update
  puts "done."
end
