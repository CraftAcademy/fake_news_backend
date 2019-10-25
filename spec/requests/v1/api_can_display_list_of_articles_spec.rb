RSpec.describe 'GET articles index' do 
  describe 'lists a collection of articles' do 
    let!(:articles) { 2.times { create(:article) } }

    before do
      get '/v1/articles'
    end

    it 'returns 2 articles' do
      expect(response_json.count).to eq 2
    end

    it 'returns the data in its correct structure' do
      expected_response = [
        {
          "id"=>Article.first.id,
          "title"=>"TitleString",
          "content"=>"ContentText"
        },
        {
          "id"=>Article.last.id,
          "title"=>"TitleString",
          "content"=>"ContentText"
        }
      ]
      expect(response_json).to eq expected_response
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