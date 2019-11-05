RSpec.describe 'Can create article with attributes' do
  let(:journalist) { create(:user, role: 'journalist') }
  let(:credentials) { journalist.create_new_auth_token}
  let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}
  let(:image) do
    [{
      type: 'application/jpg',
      encoder: 'name=new_iphone.jpg;base64',
      data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
      extension: 'jpg'
    }]
  end
  
  describe "Journalist can post a long article successfully" do

    it "returns 200 response" do
      post '/v1/articles', params: {
        title: "Which drugs can kill you?",
        content: "Drugs are bad. " * 100,
        journalist: journalist,
        image: image
      },
      headers: headers

      expect(response.status).to eq 200
    end
  end

  describe "Journalist can not post an article with 10000+ characters" do

    it "returns 400 response" do
      post '/v1/articles', params: {
        title: "Which drugs can kill you?",
        content: "Drugs are bad. " * 10000,
        journalist: journalist,
        image: image
      },
      headers: headers

      expect(response.status).to eq 400
    end
  end
end