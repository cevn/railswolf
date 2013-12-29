class CharactersController < ApplicationController 
  # before_action :correct_user,    only: [:move, :kill] 
  before_action :admin_user,      only: [:destroy] 
  

  def kill 
    game = Game.find_by_id(1)
    @killer = Character.find(params[:id]) 
    @victim = Character.find(params[:victimid]) 

    if game and game.night and game.active
      if @killer.werewolf 
        @kill = Event.new
        @kill.latitude = @victim.latitude
        @kill.longitude = @victim.longitude
        @kill.killer = @killer.name
        @kill.victim = @victim.name
        @kill.event_type = "kill" 
        @kill.save

        ## Give killer points for successfully killing somebody. 
        @killer.score += 500
        @killer.save
        @victim.dead = true
        @victim.save

        @n = Rapns::Gcm::Notification.new 
        @n.data = {:message => "You were killed!" }
        @n.app = Rapns::Gcm::App.find_by_name("droidwolf")
        @n.registration_ids = User.find(:victimid).registration_id
        @n.save!
        Rapns.push

        respond_with(@victim) do |format| 
          format.json {render :json => { :success => true } }
        end
      end
    end
  end 

  def show_alive 
    @living_chars = Character.where(:dead => :false).all
    respond_with(@living_chars)
  end

  def hi_scores
    chars = Character.all 
    respond_with(chars)
  end

  def scores 
    chars = Character.all
    respond_with(chars)
  end

  def vote 
    game = Game.find_by_id(1)
    voted = Character.find(params[:victimid])
    char = Character.find(params[:user_id]) 


    if game and !game.night and game.active and !char.voted
      voted.votes += 1
      voted.save
      char.voted = true 
      char.score += 200
      char.save
      respond_with(voted) do |format| 
        format.json {render :json => { :success => true } } 
      end
    else 
      respond_with(voted) do |format| 
        format.json {render :json => { :success => :false, :error => "You can only vote during the day!" } }
      end
    end
  end

  def move
    char = Character.find(params[:id]) 
    game = Game.find_by_id(1) 

    if game and game.active 
      if char.update_attributes(move_params)
        char.score += 10
        char.save
        respond_with(char) do |format| 
          format.json {render :json => { :success => true }} 
        end
      else 
        respond_with(char) do |format| 
          format.json {render :json => { :success => false }}
        end
      end
    end
  end

  private 
    def move_params
      params.require(:character).permit(:latitude, :longitude)
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def werewolf_char
      @user = User.find(params[:id]) 
      flash[:error] = "You must be a werewolf to view that page!" 
      redirect_to(root_url) unless user.character.werewolf?
    end
end
