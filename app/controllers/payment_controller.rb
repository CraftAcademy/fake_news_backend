class PaymentController < ApplicationController
  before_action :authenticate_user!

  def create
    @amount = 1000

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    ),
    
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'New Fake News Subscriber',
      currency: 'sek'
    )
  end
end