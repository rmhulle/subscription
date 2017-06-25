#encoding: utf-8
class ProfileController < ApplicationController

  before_filter :authenticate_user!

  def view
    @user = current_user
    @customer = @user.customer
    @subscription = @user.subscription
    @payment_methods = @user.payment_methods
    @invoices = @user.invoices
  end

  def new_payment_method
  end

  def create_payment_method
    @user = current_user
    customer = current_user.customer

    @payment_method = customer.payment_methods.create({
      description: params[:description],
      token: params[:credit_card_token]
    })

    logger.info "Payment ---- #{@payment_method.inspect}"
    
    redirect_to profile_path
  end

  def delete_payment_method
    pm = current_user.customer.payment_methods.fetch(params[:id])
    pm.delete

    redirect_to profile_path
  end

  def default_payment_method
    customer = current_user.customer
    pm = customer.payment_methods.fetch(params[:id])

    if(pm.id)
      customer.default_payment_method_id = pm.id
      customer.save
    end

    redirect_to profile_path
  end

end
