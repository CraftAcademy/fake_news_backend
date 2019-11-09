RSpec.describe 'GET catgeories index', type: :request do 
  let(:headers) {{HTTP_ACCEPT: 'application/json'}}
  describe 'lists all categoris' do 
    before do
      categories = [
        'Sports',
        'Politics',
        'Tech',
        'Economics',
        'Lifestyle',
        'Leisure'
      ]

      categories.each do |name|
        create(:category, name: name)
      end
      
    end

    it 'returns 6 categories' do
      get '/v1/categories', headers: headers
      expect(response_json.length).to eq 6
    end

    it 'returns status of 200' do
      get '/v1/categories', headers: headers
      expect(response.status).to eq 200
    end
  end
end