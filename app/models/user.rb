class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def subscribed?
    !!subscription_id
  end

  def customer
    unless customer_id
      customer = Iugu::Customer.create({ email: email }) rescue false
      update_attribute :customer_id, customer.id
      return customer
    end

    Iugu::Customer.fetch(customer_id) rescue false
  end

  def subscription
    Iugu::Subscription.fetch(subscription_id) rescue false
  end
end
