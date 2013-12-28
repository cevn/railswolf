class SessionsController < ApplicationController

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      respond_with(user) do |format| 
        format.json {render :json => { :success => true, 
                                       :remember_token => user.remember_token, 
                                       :id => user.id, 
                                       :registration_id => user.registration_id, 
                                       :werewolf => user.character.werewolf,
                                       :cur_score => user.character.score, 
                                       :max_score => user.character.max_score }}
        format.html {redirect_to user}
      end

    else
      respond_with(user) do |format| 
        format.json {render :json => { :errors => user.errors.full_messages, :success => false }}
        format.html {
          flash.now[:error] = 'Invalid email/password combination'
          render 'new'
        }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
