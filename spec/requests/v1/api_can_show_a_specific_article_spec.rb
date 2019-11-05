RSpec.describe 'Return the content of a specific article' do
  describe 'return article successfully' do

    let(:journalist) { create(:user, role: 'journalist') }
    let!(:article) { create(:article, journalist: journalist) }
    let(:credentials) { journalist.create_new_auth_token}
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}

    before do
      get "/v1/articles/#{article.id}",
      headers: headers
    end

    it 'Article has title' do
      expect(response_json['title']).to eq Article.first.title
    end

    it 'Article has content' do
      expect(response_json['content']).to eq Article.first.content
    end

    it 'Article has image' do
      expect(response_json).to include 'image'
    end

    it 'returns an affirmative response' do
      expect(response.status).to eq 200
    end
  end

  describe 'Article not found after login' do
    let(:journalist) { create(:user, role: 'journalist') }
    let!(:article) { create(:article, journalist: journalist) }
    let(:credentials) { journalist.create_new_auth_token}
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}

    before do
      get "/v1/articles/1",
      headers: headers
    end

    it 'returns correct HTTP status code' do
      expect(response.status).to eq 401
    end

    it 'returns correct error message' do
      expect(response_json["error_message"]).to eq "Unavailable content"
    end
  end

  describe 'Not signed in error' do
    let!(:article) {create(:article)}
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    before do
      get "/v1/articles/1"
    end

    it 'returns correct HTTP status code' do
      expect(response.status).to eq 401
    end

    it 'returns correct error message' do
      expect(response_json["errors"].first).to eq "You need to sign in or sign up before continuing."
    end
  end
end