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
end
