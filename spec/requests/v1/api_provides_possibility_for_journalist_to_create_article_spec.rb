RSpec.describe 'Can create article with attributes' do

  describe "user can post article successfully" do
    let(:headers) { {HTTP_ACCEPT:"application/json"} }

    before do
      post '/v1/articles', params: {
        title: "Which drugs can kill you?",
        content: "Oh it is all of them!",
        image: {
          type: 'application/jpg',
          encoder: 'name=new_iphone.jpg;base64',
          data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
          extension: 'jpg'
        }
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
end