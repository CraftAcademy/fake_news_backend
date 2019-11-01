RSpec.describe 'Return the content of a specific article' do
  describe 'return article successfully' do
    let!(:article) {create(:article)}
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    before do
      get "/v1/articles/#{article.id}"
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

  describe 'return error' do
    let!(:article) {create(:article)}
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    before do
      get "/v1/articles/1"
    end

    it 'returns correct HTTP status code' do
      expect(response.status).to eq 404
    end

    it 'returns correct error message' do
      expect(response_json["error_message"]).to eq "The article couldn't be found"
    end
  end
end