RSpec.describe 'Can create article with attributes' do
  let(:journalist) { create(:user, role: 'journalist') }
  let(:category) {FactoryBot.create(:category)}
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
  
  describe "can post article successfully" do
    

    before do
      post '/v1/articles', params: {
        title: "Which drugs can kill you?",
        content: "Oh it is all of them!",
        category: category.name,
        content: "Oh it is all of them! " * 20,
        journalist: journalist,
        image: image
      },
      headers: headers
    end

    it "returns 200 response" do  
      expect(response.status).to eq 200
    end
    
    it "that has an image attached" do
      article = Article.find_by(title: response.request.params['title'])
      expect(article.image.attached?).to eq true  
    end
  end

  describe "can not post article successfully with incomplete information" do

    before do
      post '/v1/articles', params: {
                                    title: "Wh",
                                    content: "Oh",
                                    image: image
                                  },
      headers: headers
    end

    it "returns an error status when title and content is incomplete" do
      article = Article.find_by(title: response.request.params['title'])
      expect(response.status).to eq 400
    end

    it "returns an error message when title and content is incomplete" do
      article = Article.find_by(title: response.request.params['title'])
      expect(response_json['error_message']).to eq 'Title is too short (minimum is 3 characters), Content is too short (minimum is 10 characters), and Category must exist'
    end
  end

  describe 'can not post article successfully when exceeding 10.000 characters' do
    before do
      post '/v1/articles', params: {
                                    title: 'Which drugs can kill you?',
                                    content: 'Drugs are bad. ' * 1000,
                                    journalist: journalist,
                                    image: image
                                    },
      headers: headers
    end
    it 'returns 400 response' do
      expect(response.status).to eq 400
    end

    it 'returns an error message if max content length is exceeded' do
      expect(response_json['error_message']).to eq 'Content is too long (maximum is 10000 characters) and Category must exist'
    end 
  end
end