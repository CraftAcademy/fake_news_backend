require 'rails_helper'

RSpec.describe 'GET articles index' do 
  let!(:articles) {2.times { FactoryBot.create(:article)}}
  
  describe 'lists a collection of articles' do 
    before do
      get '/v1/articles'
    end

    it 'returns 2 articles' do
      expect(response_json['articles'].count).to eq 2
    end

    it 'returns the data in its correct structure' do
      expected_response = [
        {
          "id"=>Article.first.id,
          "title"=>"TitleString",
          "content"=>"ContentText",
          "author"=>"AuthorString",
          "created_at"=>Article.first.created_at,
          "updated_at"=>Article.first.updated_at
        },
        {
          "id"=>Article.last.id,
          "title"=>"TitleString",
          "content"=>"ContentText",
          "author"=>"AuthorString",
          "created_at"=>Article.last.created_at,
          "updated_at"=>Article.last.updated_at
        }
      ]

      expect(response_json).to eq expected_response
    end
  end
end