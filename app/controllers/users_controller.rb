class UsersController < ApplicationController
  skip_before_filter :authenticate_user, :only => [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]
  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
  	@user = User.new(user_params)

    if @user.save
    	log_in @user
      redirect_to root_url, notice: 'User was successfully created'
    else
    	render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_url, notice: 'User was successfully updated'
    else
      render :edit
    end
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

  	def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  	end
end
