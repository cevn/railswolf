class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def new
    @user = User.new
    respond_with @user
  end

  def index
    @users = User.paginate(page: params[:page])
    respond_with @users
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      @user.character.lat = 37.2708
      @user.character.long = -76.7092
      @user.character.save 
      sign_in @user

      UserMailer.welcome_email(@user).deliver

      respond_with(@user) do |format|
        sign_in @user
        format.json {render :json => { :success => true, :remember_token => @user.remember_token, :id => @user.id }}
        format.html {
          flash[:success] = "Welcome to railswolf!"
          redirect_to @user
        }
      end
    end
    respond_with(@user) do |format| 
      format.json { render :json => { :errors => @user.errors.full_messages }}
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed." 
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      flash[:error] = "You must be an admin to view that page!" 
      redirect_to(root_url) unless current_user.admin?
    end

end
