class SessionsController < ApplicationController
  responds_to :json, :html

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      respond_to :json do 
        render :json => {:id => current_user.id}.to_json
      end

    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
