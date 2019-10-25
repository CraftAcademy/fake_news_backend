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
  
  describe 'lists a collection of articles' do 
    let!(:articles) { create(:article, title: nil, content: "sup") } 
    before do
      get '/v1/articles'
    end

    it "gives an error if no title is given" do
      expect(response.status).to eq 400
    end
  end
end