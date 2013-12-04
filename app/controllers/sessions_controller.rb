class SessionsController < ApplicationController
  respond_to :json, :html

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      respond_with(user) do |format| 
        format.json {render :json => { :success => true, :auth_token => form_authenticity_token, :id => @user.id }}
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
