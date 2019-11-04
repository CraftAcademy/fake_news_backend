require 'stripe_mock'

RSpec.describe 'Provides a way to add subscritption' do
  let(:user) { create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:stripe_helper) { StripeMock.create_test_helper }
  before(:each) { StripeMock.start }
  after(:each) { StripeMock.stop }
  
  describe 'User would like to pay for subscritption' do

    
    it 'User successfully pays for subscription' do
      customer = Stripe::Customer.create({
        email: 'user@mail.com',
        source: stripe_helper.generate_card_token
      })
      expect(customer.email).to eq('user@mail.com')
    end

    it 'User has insufficent funds' do
      
      binding.pry
      
      StripeMock.prepare_card_error(:card_declined)
      expect { Stripe::Charge.create(amount: 1, currency: 'usd') }.to raise_error {|e|
        expect(e).to be_a Stripe::CardError
        expect(e.http_status).to eq(402)
        expect(e.code).to eq('card_declined')
      }
    end

    it 'User has expired card' do

    end

    it 'User inputs invalid card number' do

    end

  end
end