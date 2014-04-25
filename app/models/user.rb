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

    Iugu::Customer.fetch(customer_id) rescue nil
  end

  def subscription
    Iugu::Subscription.fetch(subscription_id) if subscribed?
  end

  def payment_methods
    Iugu::PaymentMethod.search({customer_id: customer_id}).results rescue []
  end

  def invoices
    Iugu::Invoice.search( customer_id => customer_id ).results rescue []
  end
end
