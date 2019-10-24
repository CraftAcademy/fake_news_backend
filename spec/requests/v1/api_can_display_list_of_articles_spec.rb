require 'rails_helper'

RSpec.describe 'GET articles index' do 
  let!(:articles) {2.times { FactoryBot.create(:article)}}
  
  describe 'lists a collection of articles' do 
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

      
      binding.pry
      

      expect(response_json).to eq expected_response
    end
  end
end