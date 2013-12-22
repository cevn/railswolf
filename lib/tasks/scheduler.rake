desc "This task is called by the Heroku scheduler add-on"
task :update_game => :environment do
  puts "Updating game..."
  Game.update_game
  puts "done."
end

desc "This task sends out notifications, in theory" 
task :push_notifs => :environment do
  puts "Sending notifications"
  Rapns.push
  Rapns.apns_feedback
end
