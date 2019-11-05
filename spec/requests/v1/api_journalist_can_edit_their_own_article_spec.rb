RSpec.describe 'Can create and update article with attributes' do
  let(:journalist) { create(:user, role: 'journalist') }
  let!(:article) { create(:article, journalist: journalist) }
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
      put "/v1/articles/#{article.id}",
      params: {
        title: "Which drugs can kill you?",
        content: "Oh it is all of them!",
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

    it "should return a positive confirmation message" do
      expect(response_json["message"]).to eq "Article was successfully edited"
    end
  end

  describe "Unsuccessful article update due to short content" do
    before do
      put "/v1/articles/#{article.id}",    
        params: {
          title: "Which drugs can kill you?",
          content: "NONE",
          journalist: journalist,
          image: image
        },
        headers: headers
    end

    it "returns 400 response" do
      expect(response.status).to eq 400
    end

    it "returns error message" do
      expect(response_json["error_message"]).to eq "Content is too short (minimum is 10 characters)"
    end
  end

  describe "Unauthorized article update by subscriber" do
    let(:subscriber) { create(:user, role: 'subscriber') }
    let!(:article) { create(:article)}
    let(:credentials) { subscriber.create_new_auth_token}
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}

    before do
      put "/v1/articles/#{article.id}",     
        params: {
          title: "Which drugs can kill you?",
          content: "Hello I am a subscriber!",
          journalist: subscriber,
          image: image
        }, 
        headers: headers
    end

    it "returns 401 response" do  
      expect(response.status).to eq 401
    end

    it "returns error message" do
      expect(response_json["error"]).to eq "You are not authorized!"
    end
  end

  describe "Unsuccessful article update from wrong journalist" do
    let(:journalist_2) { create(:user, role: 'journalist') }
    let(:credentials) { journalist_2.create_new_auth_token}
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}

    before do
      put "/v1/articles/#{article.id}", 
        params: {
          title: "Which drugs can kill you?",
          content: "It seemed to work out fine for Hunter S. Thompson",
          journalist: journalist_2,
          image: image
        },
        headers: headers
    end

    it "returns 401 response" do
      expect(response.status).to eq 401
    end

    it "returns error message" do
      expect(response_json["error"]).to eq "You are not authorized!"
    end
  end
end