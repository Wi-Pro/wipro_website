class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
      @member = Membership.where(userid: params[:id])
      debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.name}!"
      redirect_to "/"
    else
      render 'new'
    end
  end

  def index
    redirect_to "/"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
