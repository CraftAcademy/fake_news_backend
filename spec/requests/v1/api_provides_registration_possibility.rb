RSpec.describe 'User Registration', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'with valid credentials' do

    before do 
      post '/v1/auth', 
        params: { email: 'johndoe@mail.se',
                password: 'password',
                password_confirmation: 'password'
              }, 
              headers: headers
    end

    it 'returns a user and token' do
      expect(response_json['status']).to eq 'success'
    end

    it 'returns an affirmative response' do
      expect(response.status).to eq 200
    end

  end

  describe 'with invalid password' do

    before do
      post '/v1/auth',
        params: { email: 'johndoe@mail.se',
                  password: 'password',
                  password_confirmation: 'wrong_password'
                },
                headers: headers
    end

    it 'returns error message' do
      expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
    end

    it 'return error status' do
      expect(response.status).to eq 422
    end
  end

  describe 'with invalid email' do

    before do
      post '/v1/auth',
        params: { email: 'example@craft',
                  password: 'password',
                  password_confirmation: 'password'
                },
                headers: headers
      end

      it 'returns error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end

      it 'returns error status' do
        expect(response.status).to eq 422
      end
  end

  describe 'an already registered email' do
    FactoryBot.create(:user, 
                        email: 'johndoe@mail.se',
                        password: 'password',
                        password_confirmation: 'password')
  
    before do
      post '/v1/auth',
        params: { email: 'johndoe@mail.se',
                  password: 'password',
                  password_confirmation: 'password'
                },
                headers: headers
      end

      it 'returns error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end

      it 'returns and error status' do
        expect(response.status).to eq 422
      end
    end
  end
end