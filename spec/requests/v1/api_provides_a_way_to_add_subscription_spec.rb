require 'stripe_mock'

RSpec.describe 'Provides a way to add subscritption' do
  let(:user) { create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "User would like to pay for subscritption" do

    it 'User pays for subscritption' do
      customer = Stripe::Customer.create({
        email: 'user@mail.com',
        source: stripe_helper.generate_card_token
      })
      expect(customer.email).to eq('user@mail.com')
    end

    it 'User has insufficent funds' do

    end

    it 'User has expired card' do

    end

    it 'User inputs invalid card number' do

    end

  end
end