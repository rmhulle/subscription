class AppController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_subscription

  def home
    
  end

  private

  def verify_subscription
    redirect_to subscribe_path unless current_user.subscribed?
  end

end
