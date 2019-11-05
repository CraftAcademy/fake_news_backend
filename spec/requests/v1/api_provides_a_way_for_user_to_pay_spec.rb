require 'stripe_mock'

RSpec.describe 'Provides a way to add subscription' do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token}
  let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:successful_token) { post '/v1/payments', params: {  stripeEmail: user.email,
    stripeToken: stripe_helper.generate_card_token    
    }, headers: headers
       user.reload }
  let(:unsuccessful_token) { post '/v1/payments', params: {  stripeEmail: user.email,
    stripeToken: nil    
    }, headers: headers
       user.reload }

  before { StripeMock.start }
  after { StripeMock.stop }
  
  describe 'User would like to pay for subscription' do

    it 'User successfully pays for subscription and gets a Subscriber role' do
      successful_token
      expect(response.status).to eq 200
    end
      
    it 'User should be upgraded to Subscriber role' do
      successful_token
      expect(user.role).to eq('subscriber')
    end

    it 'Response message indicates a successful transaction' do
      successful_token
      expect(response_json['message']).to eq 'Transaction successful'
    end

    it 'User role remains due to missing Stripe token' do
      unsuccessful_token
      expect(user.role).to eq('user')
    end

    it "Transaction recieves an error status of 402" do
      unsuccessful_token   
      expect(response.status).to eq 402
    end

    it 'Response message indicates a unsuccessful transaction' do
      unsuccessful_token
      expect(response_json['errors']).to eq 'No stripe token detected'
    end
  end
end