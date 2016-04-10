class SubscriptionsController < ApplicationController
  def create
    @user = current_user
    @user.subscribed = 1
    if @user.save validation: false
      flash[:success] = "You have successfully subscribed to the CSCI club news feed."
    end
    redirect_to(:back)
  end

  def destroy
    if sign_in?
      @user = current_user
      # @user.subscribed = false
      if @user.update_attribute :subscribed, true
        flash[:success] = "Unsubscribed to the new feed"
      end
    end
    # redirect_to(:back)
  end
end
