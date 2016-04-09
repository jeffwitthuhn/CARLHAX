class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:admin, :home, :index, :show, :edit, :update]
  before_action :admin_user, only: [:admin, :index, :destroy]
  before_action :correct_user_or_admin, only: [:show]
  before_action :correct_user, only: [:edit, :update]

  def home
  end

  def admin
    @user = current_user
    if @user.admin?
      @user
    else
      redirect_to @user unless current_user.admin?
    end
  end

  def index
    @users = User
  end

  def create
    p params
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Destroyed"
    redirect_to home_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to home_url unless current_user? @user
  end

  def correct_user_or_admin
    @user = User.find(params[:id])
    unless current_user? @user
      redirect_to current_user unless current_user.admin?
    end
  end

  def admin_user
    @user = current_user
    redirect_to(@user) unless current_user.admin?
  end
end
