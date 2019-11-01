RSpec.describe 'GET articles index' do 
  describe 'lists a collection of articles' do 
    let!(:articles) { 2.times { create(:article) } }
    before do
      get '/v1/articles'
    end

    it 'returns 2 articles' do
      expect(response_json.count).to eq 2
    end

    it 'Article has title' do
      expect(response_json.first['title']).to eq Article.first.title
    end

    it 'Article has content' do
      expect(response_json.first['content']).to eq Article.first.content
    end

    it 'Article has image' do
      expect(response_json.first).to include 'image'
    end
  end
  
  describe 'returns error if there\'s no articles in the database' do 
    before do
      get '/v1/articles'
    end

    it 'returns error status' do
      expect(response.status).to eq 404
    end

    it 'returns error message' do
      expect(response_json["error_message"]).to eq "There are no articles here"
    end
  end
end