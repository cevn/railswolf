class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  respond_to :json, :html

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      respond_with(user) do |format| 
        format.json {render :json => { :success => true, :auth_token => form_authenticity_token, :id => @user.id }}
        format.html {redirect_to user}
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
