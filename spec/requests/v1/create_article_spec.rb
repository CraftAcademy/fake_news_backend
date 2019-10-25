RSpec.describe 'POST articles create' do 
  describe 'User can post article successfully' do
    let(:headers) { { HTTP_ACCEPT: "application/json" } }

    before do
      post '/v1/articles', 
      params: {
        title: 'New iPhone on the way',
        content: 'A lot of new features coming',
        image: {
          type: 'application/jpg',
          encoder: 'name=new_iphone.jpg;base64',
          data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
          extension: 'jpg'
        }
      },
      headers: headers
    end

    it 'returns 200 response' do
      expect(response.status).to eq 200
    end

    it 'that has image attached' do
      article = Article.find_by(title: response.request.params['title'])      
      expect(article.image.attached?).to eq true
    end
  end
end
