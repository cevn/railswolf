class SessionsController < ApplicationController
  respond_to :json, :html
  skip_before_filter :verify_authenticity_token, 
    :if => Proc.new { |c| c.request.format == 'application/json' }

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if user && user.authenticate(params[:session][:password]) #because user has_secure_password
        format.html { sign_in user, notice: "Login successful!" }
        format.json { render :json => {:success => true,
                      :info => "Logged in", :token => form_authenticity_token } }
      else
        format.html { flash.now.alert = "Wrong email or password"
                    render "new" }
        format.json { render :json => {:success => false, :info => "Wrong email or password" } }
      end
    end
  end
    
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
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
