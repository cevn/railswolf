desc "This task is called by the Heroku scheduler add-on"
task :update_game => :environment do
  puts "Updating game..."
  Game.update
  puts "done."
end
