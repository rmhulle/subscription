#encoding: UTF-8
class SubscriptionController < ApplicationController
  before_filter :authenticate_user!

  def subscribe
    if params[:p]
      @plan = Iugu::Plan.fetch_by_identifier(params[:p]) rescue nil
    end
    @plans = Iugu::Plan.search.results unless @plan
    @payment_method = "credit_card"
  end

  def subscribe_to_plan
    customer = current_user.customer
    if params[:payment_method] == "credit_card"
      customer.payment_methods.create({
        description: "Cartão de Crédito",
        token: params[:credit_card_token],
        set_as_default: true
      })
    end

    sub_params = {
      plan_identifier: params[:plan_identifier], 
      customer_id: customer.id
    }
    sub_params[:only_on_charge_success] = true if params[:payment_method] == "credit_card"

    subscription = Iugu::Subscription.create(sub_params)

    if subscription.errors
      Rails.logger.info "TESTE"
      Rails.logger.info subscription.errors
      Rails.logger.info subscription
      @plan = Iugu::Plan.fetch_by_identifier(params[:plan_identifier])
      @payment_method = params[:payment_method]
      @error = "Erro na Cobrança!"
      return render :subscribe
    end

    current_user.subscription_id = subscription.id
    current_user.save

    redirect_to profile_url
  end
end
