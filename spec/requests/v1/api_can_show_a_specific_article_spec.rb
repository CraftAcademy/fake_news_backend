RSpec.describe 'Return the content of a specific article' do
  describe 'return article successfully' do
    let!(:article) {create(:article)}
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    before do
      get "/v1/articles/#{article.id}"

    end

    it 'returns the data in its correct structure' do
      expected_response =
        {
          "id"=>Article.last.id,
          "title"=>"TitleString",
          "content"=>"ContentText"
        }
           
      expect(response_json).to eq expected_response      
    end
  end

  describe 'return error' do
    let!(:article) {create(:article)}
    let(:headers) { { HTTP_ACCEPT: 'application/json' } }

    before do
      get "/v1/articles/1"
    end

    it 'returns error' do
      expect(response.status).to eq 404
      expect(response_json["error_message"]).to eq "The article couldn't be found"
    end
  end

end