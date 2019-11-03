RSpec.describe 'User Login', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'User tries to login with valid credentials' do
    it 'valid credentials returns user' do
      post '/auth/sign_in', params: {  email: user.email,
                                          password: user.password
                                       }, headers: headers

      expected_response = {
        'data' => {
          'id' => user.id, 'uid' => user.email, 'email' => user.email,
          'provider' => 'email', 'name' => nil, 'nickname' => nil,
          'role' => user.role, 'image' => nil, 'allow_password_change' => false,
        }    
      }

      expect(response_json).to eq expected_response
    end
  end

    describe 'Tries to login using invalid credentials' do   
    
      before do
        post '/auth/sign_in', params: {  email: user.email,
                                            password: 'wrong_password'
                                         }, headers: headers
      end

      it 'invalid password returns error message' do
        expect(response_json['errors'])
          .to eq ['Invalid login credentials. Please try again.']
      end
      
      it 'invalid password returns error status' do
        expect(response.status).to eq 401
      end

      before do
        post '/auth/sign_in', params: {  email: 'wrong@email.com',
                                            password: user.password
                                         }, headers: headers
      end

      it 'invalid email returns error message' do
        expect(response_json['errors'])
          .to eq ['Invalid login credentials. Please try again.']
      end

      it 'invalid email returns error status' do
        expect(response.status).to eq 401
      end
    end
end