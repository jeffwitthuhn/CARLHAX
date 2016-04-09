class SubscriptionsController < ApplicationController
  def create
    @user = current_user
    @user.subscribed = true
    flash[:success] = "You have successfully subscribed to the CSCI club news feed."
    if @user.save
      puts "test"
      p @user
      puts "test"
    end
    redirect_to(:back)
  end

  def destroy
    if sign_in?
      @user = current_user
      @user.subscribed = false
      if @user.save
        flash[:success] = "Unsubscibed to the new feed"
      end
    end
  end
end
