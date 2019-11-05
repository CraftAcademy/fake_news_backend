RSpec.describe 'Can create article with attributes' do
  let(:journalist) { create(:user, role: 'journalist') }
  let(:credentials) { journalist.create_new_auth_token}
  let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}
  let(:error_post) {post '/v1/articles', params: {
                                          title: 'Which drugs can kill you?',
                                          content: 'Drugs are bad. ' * 1000,
                                          journalist: journalist,
                                          image: image
                                          },
                                          headers: headers}
  let(:image) do
    [{
      type: 'application/jpg',
      encoder: 'name=new_iphone.jpg;base64',
      data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
      extension: 'jpg'
    }]
  end
  
  describe 'Journalist can post a long article while not exceeding 10.000 chars' do

    it 'returns 200 response' do
      post '/v1/articles', params: {
        title: 'Which drugs can kill you?',
        content: 'Drugs are bad. ' * 100,
        journalist: journalist,
        image: image
      },
      headers: headers

      expect(response.status).to eq 200
    end

    it 'returns 400 response' do
      error_post
      expect(response.status).to eq 400
    end

    it 'returns an error message if max content length is exceeded' do
      error_post
      expect(response_json['error_message']).to eq 'Content is too long (maximum is 10000 characters)'
    end 
  end
end