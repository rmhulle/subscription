class ProfileController < ApplicationController

  before_filter :authenticate_user!

  def view
    @user = current_user
    @subscription = @user.subscription
    @payment_methods = @user.payment_methods
    @invoices = @user.invoices
  end

  def new_payment_method
  end

  def create_payment_method

    
  end

end
