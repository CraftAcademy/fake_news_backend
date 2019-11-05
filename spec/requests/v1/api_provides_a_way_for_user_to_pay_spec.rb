require 'stripe_mock'

RSpec.describe 'Provides a way to add subscription' do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token}
  let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }
  
  describe 'User would like to pay for subscritption' do

    it 'User successfully pays for subscription & gets a subscriber role' do
      
      post '/v1/payments', params: {  stripeEmail: user.email,
                                      stripeToken: stripe_helper.generate_card_token    
                                      }, headers: headers
      user.reload
      expect(response.status).to eq 200
      expect(user.role).to eq('subscriber')
    end

    it 'Transaction fails due to missing Stripe token & still has user role' do
      post '/v1/payments', params: {  stripeEmail: user.email,
                                      stripeToken: nil    
                                      }, headers: headers
      user.reload
      expect(user.role).to eq('user')
      expect(response.status).to eq 402
    end
  end
end