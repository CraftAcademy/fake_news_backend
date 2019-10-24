require 'rails_helper'

RSpec.describe 'Get ./requests/v1 ' do 
  let!(:articles) {2.times { FactoryBot.create(:article)}}
  
  it 'lists a collection of articles' do 
  get '/v1/article'

  json_resp = JSON.parse(response.body)
  expect(json_reps['articles'].count).to eq 2
  end
end