RSpec.describe 'User Registration', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'with valid credentials' do

    before do 
      post '/auth', 
        params: { 
                email: 'johndoe@mail.se',
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

  describe 'a non-matching password confirmation' do

    before do
      post '/auth',
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

  describe 'submits an invalid email adress' do

    before do
      post '/auth',
        params: { email: 'johndoe@mail',
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

  describe 'submits an already registered email' do
    
    before do
      create(:user, 
             email: 'johndoe@mail.se',
             password: 'password',
             password_confirmation: 'password')
    
      post '/auth', 
      params: { email: 'johndoe@mail.se',
                password: 'password',
                password_confirmation: 'password'
              }, 
              headers: headers
    end

      it 'returns error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end

      it 'it returns error status' do
        expect(response.status).to eq 422
      end
  end
end